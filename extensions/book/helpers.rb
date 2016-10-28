module Book
  module Helpers
    # Determine if current page is a chapter (i.e. a Sitemap::resource w/sort_order)
    # By default it checks the value of current_page; can accept any resource object as well
    # @return [Boolean]
    # def page_is_chapter?
    #   return false unless current_page.data.sort_order
    #   true
    # end

    # Determine if there is a chapter before the current page
    # @return Middleman::Sitemap::Resource of the previous page
    def prev_chapter_path
      return false unless current_page.respond_to?(:prev_chapter)
      current_page.prev_chapter
    end

    # Determine if there is a chapter after the current page
    # @return Middleman::Sitemap::Resource of the next page
    def next_chapter_path
      return false unless current_page.respond_to?(:next_chapter)
      current_page.next_chapter
    end

    def creator_name
      book = data.book
      "#{creator.first_name} #{creator.last_name}"
    end

    # --------------------------------------------------------------------------
    # Book info methods
    # Used to build up the complex strings used in the citation partial
    def book_info_chicago
      book = data.book
      path = current_path.gsub("index.html", "")
      %(
        In <em>#{book.title.main}</em>,
        edited by #{book.creator.first.first_name} #{book.creator.first.last_name}.
        #{book.edition_number} ed.
        #{book.publisher_location}:
        #{book.publisher},
        #{book.pub_date.year}.
        <span class="force-wrap">#{permalink}/#{path}</span>.
      )
    end

    def book_info_mla
      book = data.book
      path = current_path.gsub("index.html", "")
      %(
        <em>#{book.title.main}</em>. Ed. #{author_name}.
        #{book.edition_number} ed.
        #{book.publisher_location}:
        #{book.publisher_short}, #{book.pub_date.year}.
        <span class="cite-current-date">DD Mon. YYYY</span>
        <<span class="force-wrap">#{permalink}/#{path}</span>>.
      )
    end

    # --------------------------------------------------------------------------
    # Default author
    # Return default author name in citation format (last, first)
    def default_author
      book = data.book
      "#{book.creator.first.last_name}, #{book.creator.first.first_name}"
    end

    def permalink
      data.book.editions.find { |edition| edition.name == "Online" }.link
    end

  end
end
