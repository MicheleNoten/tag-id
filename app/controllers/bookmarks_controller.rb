class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    # @scans = current_user.scans
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :product_id)
  end
end
