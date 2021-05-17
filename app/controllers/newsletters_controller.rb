class NewslettersController < ApplicationController
  before_action :set_newsletter, only: %i[ show edit update destroy ]

  # GET /newsletters
  def index
    @newsletters = Newsletter.all
  end

  # GET /newsletters/1
  def show
  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
  end

  # POST /newsletters
  def create
    #Create newsletter
    @newsletter = Newsletter.new(newsletter_params)
    respond_to do |format|
      #Set the newsletter_params in params var
      params = newsletter_params
      #Valid if all preference are zero or false
      if params[:woman] == "0" && params[:man] == "0" && params[:child] == "0"
        #Add preferences_error message to return to view
        @newsletter.errors.add(:preferences, t('preferences_error'))
        #Render in html and json format the model errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      else
        if @newsletter.save
          #Render in html and json format the model notice
          format.html { redirect_to @newsletter, notice: t('preferences_success') }
          format.json { render :show, status: :created, location: @newsletter }
        else
          #Render in html and json format the model errors
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @newsletter.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /newsletters/1
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to @newsletter, notice: "Newsletter was successfully updated." }
        format.json { render :show, status: :ok, location: @newsletter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to newsletters_url, notice: "Newsletter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def newsletter_params
      params.require(:newsletter).permit(:email, :woman, :man, :child)
    end
end
