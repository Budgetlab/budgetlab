require "google/cloud/storage"

class DocumentsController < ApplicationController
  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create
    file = params[:document][:file]
    nom_fichier_original = file.original_filename
    @document = Document.new(file: file, name: nom_fichier_original)
    if @document.save
      # Téléchargement du fichier sur GCS
      bucket_name = 'budgetlab-bucket'
      storage = Google::Cloud::Storage.new(project_id: 'apps-354210')
      bucket = storage.bucket(bucket_name)

      puts params[:document][:file].original_filename

      nom_fichier = @document.id.to_s + "_" + @document.name
      file = bucket.create_file(file.tempfile, nom_fichier)

      # Enregistrement du lien du fichier dans la base de données
      @document.update(file: file.public_url)

      redirect_to documents_path, notice: "Le document a été importé avec succès."
    else
      render :new
    end
  end

  def destroy
    @document = Document.find(params[:id])

    # Suppression du fichier dans GCS
    bucket_name = 'budgetlab-bucket'
    storage = Google::Cloud::Storage.new(project_id: 'apps-354210')
    bucket = storage.bucket(bucket_name)
    filename = @document.file.gsub("https://storage.googleapis.com/budgetlab-bucket/", "")
    # Supprimez le fichier dans GCS en utilisant son chemin ou son nom
    bucket.file(filename).delete

    # Supprimez le document de la base de données
    @document.destroy

    redirect_to documents_url
  end

  private

  def document_params
    params.require(:document).permit(:name, :file)
  end
end
