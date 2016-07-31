class GroupsController < ApplicationController

	def create
		@group = Group.new(params[:group])

		if @group.save
			flash[:notice] = "Group Created, user is a member in it"
		else
			flash[:notice] = "Group Created, user not in it"
		end
	end

end