module ContactsHelper
	# Returns the Gravatar (http://gravatar.com/) for the given contact.
	def contact_gravatar(contact, options = { size: 50 })
		gravatar_id = Digest::MD5::hexdigest(contact.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: contact.full_name, class: "gravatar")
	end
end
