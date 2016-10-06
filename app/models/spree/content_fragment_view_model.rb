module Spree
  class ContentFragmentViewModel
    attr_reader :fragment

    def initialize(fragment)
      @fragment = fragment
    end

    delegate :title, to: :fragment
    delegate :body, to: :fragment

    def tag_id
      "content_fragment_#{@fragment.id}"
    end

    def style_tag_content
      scss <<-SCSS
        ##{tag_id} {
          #{background_style}
          #{@fragment.style}
        }
      SCSS
    end

    protected

    def background_style
      return nil unless @fragment.background_image.present?
      "background-image: url(#{@fragment.background_image.url(:original)});"
    end

    def scss(string)
      return '' if string.blank?
      Sass::Engine.new(string, syntax: :scss).render
    end
  end
end
