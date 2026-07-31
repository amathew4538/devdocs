module Docs
    class RobotPy < UrlScraper
        # Basic Info
        self.name = 'RobotPy'
        self.slug = 'robot_py'
        self.type = 'sphinx'

        # URL Stuff
        self.base_url = 'https://robotpy.readthedocs.io/'
        self.root_path = 'projects/robotpy/en/stable/index.html'
        self.links = {
            home: 'https://robotpy.readthedocs.io/projects/robotpy/en/stable/',
            code: 'https://github.com/robotpy/mostrobotpy'
        }

        # Its a Sphinx-based site
        html_filters.push 'robot_py/entries', 'sphinx/clean_html', 'robot_py/clean_html'
        
        options[:attribution] = <<-HTML
        &copy; 2011&ndash;Present FIRST and other WPILib Contributors <br>
        Licensed under the BSD 3-Clause License.
        HTML

        # Skip Indecies
        options[:skip] = [
            'genindex.html',
            'py-modindex.html'
        ]

        # Skips the Overview part of the index.html
        options[:skip_patterns] = [
            /\A\.\.\//, # Ignore parent links
            /\Ahttps?:\/\/(?!robotpy\.readthedocs\.io\/projects\/)/ # Block non-robotpy subproject specific URLs
        ]

        # Gets the version from PyPi (Probably bad practice)
        def get_latest_version(opts) 
            response = fetch('https://pypi.org/pypi/robotpy/json', opts)
            if response.success?
                json = JSON.parse(response.body)
                json.dig('info', 'version')
            else
                '2026.2.2' # fallback matching most recent wpilib versions of July 2026
            end
        rescue
            '2026.2.2' # same here
        end
    end
end