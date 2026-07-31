module Docs
  class WpilibCpp
    class CleanHtmlFilter < Filter
      def call
        if current_url.path.to_s.include?('index.html')
          # Build a clean landing page layout for it since the main one is bad
          doc.inner_html = <<-HTML
            <h1>WPILib C++ Documentation</h1>
            <p>Welcome to the official WPILib C++ API Reference for FIRST Robotics Competition (FRC).</p>

            <h2>Quick Navigation</h2>
            <ul>
            <li><strong>Classes & Structs:</strong> Core robotics classes like <code>frc::SwerveDriveKinematics</code>, <code>frc::PIDController</code>, and motor controller interfaces.</li>
            <li><strong>Namespaces:</strong> Logical groupings such as <code>frc</code>, <code>wpi</code>, and <code>units</code>.</li>
            <li><strong>Topics / Groups:</strong> High-level module overviews and subsystem utilities.</li>
            </ul>

            <h2>Resources</h2>
            <ul>
            <li><a href="https://docs.wpilib.org" target="_blank" rel="noopener">WPILib Official Documentation & Guides</a></li>
            <li><a href="https://github.com/wpilibsuite/allwpilib" target="_blank" rel="noopener">WPILib Suite GitHub Repository</a></li>
            </ul>
          HTML

          return doc
        end
        # Remove Doxygen header, logo, search box, navigation bar,footer, search scripts
        css('#titlearea', '#MSearchSelectWindow', '#MSearchResultsWindow', '#nav-path', '.summary', '.sm-nowrap', '.footer', 'address', 'script').remove

        # Remove Permalink symbol
        css('a.permalink', '.permalink').remove

        # Header into an actual header
        if (title_node = at_css('.headertitle .title', '.title'))
          h1 = Nokogiri::XML::Node.new('h1', doc)
          h1.content = title_node.text.strip

          # Replace header container or title div with h1
          header_container = at_css('.header') || title_node
          header_container.replace(h1)
        end

        # turn doxygen code table to codeblock
        css('.memitem').each do |item|
          proto_table = item.at_css('.memproto table.memname')
          next unless proto_table

          code_text = proto_table.text.gsub(/\s+/, ' ').strip

          pre = Nokogiri::XML::Node.new('pre', doc)
          pre['data-language'] = 'cpp'
          pre.content = code_text

          item.at_css('.memproto').replace(pre)
        end

        # Strip styling on headers
        css('h1', 'h2', 'h3').each do |header|
          header.delete('style')
          header.content = header.text.delete('◆').strip
        end

        doc
      end
    end
  end
end
