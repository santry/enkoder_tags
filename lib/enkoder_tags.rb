module EnkoderTags
  include Radiant::Taggable

  class TagError < StandardError; end

  desc %{
    Everything within <r:enkode></r:enkode> tags will be obfuscated using 
    javascript.
    
    Be aware that obfuscated content will not be visible to web clients 
    which do not have javascript enabled.
  }
  tag "enkode" do |tag|
    Enkoder.new(tag.expand).enkode
  end

  desc %{
    The enkode_mailto tag obfuscates mailto links. This makes it very 
    difficult for robots to harvest email addresses, allowing you to publish 
    email addresses on the web without attracting spam.
    
    The enkode_mailto tag accepts the following attributes as tags:
    
    * @email@ (_manadatory_) - the email address you want to publish
    * @link_text@ - The text which will display in the link 
      (if left blank, email address is used)
    * @title_text@ - Populates the @title@ attribute
    * @subject@ - Text entered here will be used as the _Subject_ for emails
    
    Any additional attributes (e.g. @class@ or @id@) provided will also be 
    applied to the tag.
    
    *Usage:*

    <pre><code><r:enkode_mailto email="hello@example.com" link_text="Say hello"
    title_text="Click here to say hello by email" subject="Hello" />
    </code></pre>
    
    Be aware that browsers which do not have javascript enabled will not see 
    the email address.
  }
  tag "enkode_mailto" do |tag|
    attr = tag.attr.symbolize_keys
    
    raise TagError.new("Please provide an `email' attribute for the `enkode_mailto' tag.") unless attr.has_key?(:email)
    
    # default to using the email address as the link_text
    link_text = attr[:link_text] || attr[:email]
    
    attrs = tag.attr.dup
    attrs.delete('email')
    attrs.delete('title_text')
    attrs.delete('subject')
    attrs.delete('link_text')
    
    Enkoder.new.enkode_mailto(
      attr[:email], link_text, attr[:title_text], attr[:subject], attrs
    )
  end

end    