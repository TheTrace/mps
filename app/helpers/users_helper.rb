module UsersHelper

	#def gravatar_for(user, options = { :size => 50 })
	#	gravatar_image_tag(user.email.downcase, :alt => user.name,
	#											:class => 'gravatar',
	#											:gravatar => options)
	#end

	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

end
