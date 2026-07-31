module Docs
    class RobotPy
        class EntriesFilter < Docs::EntriesFilter
            def get_name
                # Use primary heading or document title
                name = at_css('h1')&.text&.strip
                return unless name

                # Strip permalink stuff
                name.gsub!(/[\uE000-\uF8FF¶#]/, '')
                name.strip
                name
            end

            def get_type
                path = current_url.path.to_s

                # Main 3rd-party vendors in RobotPy
                if path.include?('/projects/rev/')
                    'REVLib API'
                elsif path.include?('/projects/phoenix5/') || path.include?('/projects/phoenix6/')
                    'CTRE Phoenix API'
                elsif path.include?('/projects/navx/')
                    'NavX API'
                elsif path.include?('/projects/pathplanner/')
                    'PathPlanner API'

                # Core RobotPy API
                elsif path.include?('/ntcore')
                    'NTCore API'
                elsif path.include?('/cscore')
                    'CSCore API'
                elsif path.include?('/robotpy_apriltag') || path.include?('/apriltag')
                    'Apriltag API'
                elsif path.include?('/wpilib')
                    'WPILib API'
                elsif path.include?('/wpimath')
                    'WPIMath API'
                elsif path.include?('/wpinet')
                    'WPINet API'
                elsif path.include?('/wpiutil')
                    'WPIUtil API'
                elsif path.include?('/hal')
                    'HAL API'
                elsif path.include?('/romi')
                    'ROMI API'
                elsif path.include?('/xrp')
                    'XRP API'
                elsif path.include?('/commands2')
                    'Commands V2 API'
                else
                    'Extra'
                end
            end
        end
    end
end