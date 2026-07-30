module Docs
    class WpilibJava < UrlScraper
        # Generic Settings
        self.name = 'WPILib Java'
        self.slug = 'wpilib_java'

        # It's a standard NEW JavaDoc site
        self.type = 'openjdk'
        self.links= {
            # The docs code
            home: 'https://github.wpilib.org/allwpilib/docs/release/java/',
            # The main code
            code: 'https://github.com/wpilibsuite/allwpilib'
        }

        # Attribution Statement
        options[:attribution] = <<-HTML
        &copy; 2019&ndash;Present FIRST and other WPILib Contributors <br>
        Licensed under the BSD 3-Clause License.
        HTML

        # Skip URLs when parsing
        options[:skip] = [
            'overview-tree.html',
            'deprecated-list.html',
            'index-all.html',
            'help-doc.html',
            'constant-values.html',
            'serialized-form.html',
            'allclasses-index.html',
            'allpackages-index.html'
        ]

        # Main area to parse in the HTML
        options[:container] = 'main, div.header, div.contentContainer'

        # Removes slashes at the end of doc's URL
        options[:trailing_slash] = false

        # Base link to pull from
        self.base_url = 'https://github.wpilib.org/allwpilib/docs/release/java/'
        # The main url
        self.root_path = 'index.html'

        html_filters.push 'openjdk/entries_new', 'openjdk/clean_html_new'

        # Current WPILib Version
        def get_latest_version(opts)
            # Get the main doc
            doc = fetch_doc('https://github.wpilib.org/allwpilib/docs/release/java/index.html', opts)
            # Get version from css file
            heading = doc.at_css('h1.title') || doc.at_css('div.header h1')
            # Remove the starter text
            heading.content.sub('WPILib API ', '').strip
        end
    end
end