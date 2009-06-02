class EnkoderTagsExtension < Radiant::Extension
  version "0.1"
  description "Provides tags for hiding web content from robots using Dan Benjamin's Enkoder"
  url "http://github.com/santry/enkoder_tags"
  
  def activate
    Page.send :include, EnkoderTags
  end
end
