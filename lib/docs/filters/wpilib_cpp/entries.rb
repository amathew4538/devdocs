module Docs
    class WpilibCpp
        class EntriesFilter < Docs::EntriesFilter
            def get_name
                path = current_url.path.to_s

                # retirn nil on doxygen_crawl
                return nil if path.include?('doxygen_crawl')

                # Name for index.html
                if root_page? || path.include?('index.html')
                    return 'Overview'
                end

                # Clean up HTML title tags
                name = at_css('.title', '#titlearea', 'h1')&.text&.strip
                name&.delete_prefix('Class ')&.delete_prefix('Struct ')&.delete_prefix('Namespace ')
            end

            def get_type
                # Categorize search entries based on URL
                path = current_url.path.to_s
                
                if path.include?('class') || path.include?('struct')
                    'Classes'
                elsif path.include?('namespace')
                    'Namespaces'
                elsif path.include?('concept')
                    'Concepts'
                elsif path.include?('group')
                    'Topics'
                else
                    'Files' # Fallback type so no nils
                end
            end
        end
    end
end