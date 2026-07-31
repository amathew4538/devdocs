module Docs
  class WpilibCpp < UrlScraper
    # Generic Settings
    self.name = 'WPILib C++'
    self.slug = 'wpilib_cpp'

    # There is no doxygen preset so simple will work
    self.type = 'simple'
    self.links= {
      # The docs code
      home: 'https://github.wpilib.org/allwpilib/docs/release/cpp/',
      # The main code
      code: 'https://github.com/wpilibsuite/allwpilib'
    }

    # Copyright
    options[:attribution] = <<-HTML
    &copy; 2019&ndash;Present FIRST and other WPILib Contributors <br>
    Licensed under the BSD 3-Clause License.
    HTML

    # Base link to pull from
    self.base_url = 'https://github.wpilib.org/allwpilib/docs/release/cpp/'
    # The main url
    self.root_path = 'doxygen_crawl.html'

    # Removes slashes at the end of doc's URL
    options[:trailing_slash] = false

    # HTML area to look in
    options[:container] = '#doc-content, .contents, main, body'

    # Skip urls
    options[:skip] = [
      'md__2home_2runner_2work_2allwpilib_2allwpilib_2_l_i_c_e_n_s_e.html',
      'deprecated.html',
      'todo.html',
      'files.html',
      'pages.html',
      'namespaces.html',
      'annotated.html'
    ]

    options[:only_patterns] = [
      /\Aclass/,
      /\Astruct/,
      /\Anamespace/,
      /\Aconcept/,
      /\Agroup/,
      /\A[a-z0-9_]+\_8h\.html/,
      /\Aindex\.html\z/
    ]

    html_filters.push 'wpilib_cpp/clean_html', 'wpilib_cpp/entries'

    def get_latest_version(opts)
      # Pull main doc
      doc = fetch_doc('https://github.wpilib.org/allwpilib/docs/release/cpp/index.html', opts)
      # Pull version from title bar
      title = doc.at_css('.projectnumber') || doc.at_css('#projectnumber')
      # Strip extra content if exists
      title ? title.content.strip : '2026.2.2'
    end
  end
end
