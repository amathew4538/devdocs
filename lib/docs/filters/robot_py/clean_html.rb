module Docs
    class RobotPy
        class CleanHtmlFilter < Filter
            def call
                # remove links
                css('a.headerlink', '.headerlink').remove
                # remove extra html/css stuff
                css('.wy-nav-side', '.wy-breadcrumbs', '.wy-nav-top', 'footer', '.rst-footer-buttons', '[role="contentinfo"]').remove
                doc
            end
        end
    end
end