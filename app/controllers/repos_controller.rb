class ReposController < ApplicationController
  before_action :set_repo, only: %i[ show update destroy ]
  before_action :set_user

  # GET /repos
  def index
    @repos = @user.repos
    render json: @repos
  end

  # GET /repos/1
  def show
    render json: @repo
  end

  # POST /repos
  def create
    @repo = Repo.new(repo_params)

    if @repo.save
      render json: @repo, status: :created, location: @repo
    else
      render json: @repo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /repos/1
  def update
    if @repo.update(repo_params)
      render json: @repo
    else
      render json: @repo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /repos/1
  def destroy
    @repo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params.expect(:slug))
    end

  def set_user
    @user = User.find_by_slug(params.expect(:user_slug))
  end

    # Only allow a list of trusted parameters through.
    def repo_params
      params.expect(repo: [ :name, :slug, :user_id ])
    end
end
