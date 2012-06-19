module Cms
  module UiElementsHelper

    # Renders a Save And Publish button if:
    # 1. Current User has publish rights
    # 2. Block is publishable
    def save_and_publish_button(block, content_type)
      if current_user.able_to?(:publish_content) && block.publishable?
        html = %Q{<button type="submit" name="#{content_type.content_block_type.singularize}[publish_on_save]" value="true" class="submit" tabindex="#{next_tabindex}"><span>Save And Publish</span></button>}
        lt_button_wrapper html.html_safe
      end
    end

    # For simple publish buttons
    def publish_button(type)
      html = %Q{<button type="submit" name="#{type}[publish_on_save]" value="true" class="submit"><span>Save And Publish</span></button>'}
      lt_button_wrapper html.html_safe
    end


    def select_content_type_tag(type, &block)
      options = {:rel => "select-#{type.key}"}
      if (defined?(content_type) && content_type == type)
        options[:class] = "on"
      end
      content_tag_for(:li, type, nil, options, &block)
    end

    # Used by Twitter Bootstrap dropdown menus used to divide groups of menu items.
    # @param [Integer] index
    def divider_tag(index = 1)
      tag(:li, class: "divider") if index != 0
    end

    def nav_link_to(name, link, options={})
      content_tag(:li, link_to(name, link, options.merge({:target => "_top"})))
    end
  end
end