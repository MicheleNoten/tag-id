class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :product_id)
  end
end
