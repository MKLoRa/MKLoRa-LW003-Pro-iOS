#
# Be sure to run `pod lib lint MKLoRaWAN-AF.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-AF'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MKLoRaWAN-AF.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lovexiaoxia/MKLoRaWAN-AF'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/lovexiaoxia/MKLoRaWAN-AF.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-AF' => ['MKLoRaWAN-AF/Assets/*.*']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-AF/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.subspec 'SyncDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-AF/Classes/DatabaseManager/SyncDatabase/**'
    end
    
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-AF/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-AF/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-AF/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-AF/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-AF/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-AF/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'TextButtonCell' do |sss|
      sss.source_files = 'MKLoRaWAN-AF/Classes/Expand/TextButtonCell/**'
    end
    
    ss.subspec 'ReportTimePointCell' do |sss|
      sss.source_files = 'MKLoRaWAN-AF/Classes/Expand/ReportTimePointCell/**'
    end
    
    ss.subspec 'TimingModeAddCell' do |sss|
      sss.source_files = 'MKLoRaWAN-AF/Classes/Expand/TimingModeAddCell/**'
    end
    
    ss.subspec 'FilterCell' do |sss|
      sss.subspec 'FilterBeaconCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Expand/FilterCell/FilterBeaconCell/**'
      end
      
      sss.subspec 'FilterByRawDataCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Expand/FilterCell/FilterByRawDataCell/**'
      end
      
      sss.subspec 'FilterEditSectionHeaderView' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Expand/FilterCell/FilterEditSectionHeaderView/**'
      end
      
      sss.subspec 'FilterNormalTextFieldCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Expand/FilterCell/FilterNormalTextFieldCell/**'
      end
      
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'ScanTimePointModel' do |sss|
      sss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanTimePointModel/**'
    end
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'AlarmPayloadSettingsPage' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/AlarmPayloadSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/AlarmPayloadSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/AlarmPayloadSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'BatteryConsumptionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BatteryConsumptionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/BatteryConsumptionPage/Model'
        ssss.dependency 'MKLoRaWAN-AF/Functions/BatteryConsumptionPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BatteryConsumptionPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BatteryConsumptionPage/View/**'
      end
    end
    
    ss.subspec 'BleGatewaySettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BleGatewaySettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/BleGatewaySettingsPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanReportPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/FilterSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentPage/Controller'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BleGatewaySettingsPage/Model/**'
      end
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/BleSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-AF/Functions/BleSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BleSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/BleSettingsPage/View/**'
      end
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/DebuggerPage/View/**'
      end
      
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/SelftestPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/DebuggerPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/BatteryConsumptionPage/Controller'
        
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end
    
    ss.subspec 'DeviceSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/DeviceSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/DeviceSettingsPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/SynDataPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/IndicatorSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/DeviceInfoPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/OnOffSettingsPage/Controller'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/DeviceSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'FilterByRawDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/FilterByRawDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/FilterByRawDataPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/FilterByRawDataPage/Model/**'
      end
      
    end
    
    ss.subspec 'FilterSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/FilterSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-AF/Functions/FilterSettingPage/Model'
        ssss.dependency 'MKLoRaWAN-AF/Functions/FilterSettingPage/View'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/FilterByRawDataPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/FilterSettingPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/FilterSettingPage/View/**'
      end
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/BleSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/THSettingsPage/Controller'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/IndicatorSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/IndicatorSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/IndicatorSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/LoRaApplicationPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/MulticaseGroupPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/MessageTypePage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'MessageTypePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/MessageTypePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/MessageTypePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/MessageTypePage/Model/**'
      end
      
    end
    
    ss.subspec 'MulticaseGroupPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/MulticaseGroupPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/MulticaseGroupPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/MulticaseGroupPage/Model/**'
      end
      
    end
    
    ss.subspec 'OnOffSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/OnOffSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/OnOffSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/OnOffSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'PayloadContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentPage/Controller/**'
                        
        ssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections'
      end
      
    end
    
    ss.subspec 'PayloadContentSelections' do |sss|
      
      sss.subspec 'BeaconContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BeaconContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BeaconContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BeaconContentPage/Model/**'
        end
      end
      
      sss.subspec 'BXPAccContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPAccContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BXPAccContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPAccContentPage/Model/**'
        end
      end
      
      sss.subspec 'BXPBeaconContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPBeaconContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BXPBeaconContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPBeaconContentPage/Model/**'
        end
      end
      
      sss.subspec 'BXPButtonContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPButtonContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BXPButtonContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPButtonContentPage/Model/**'
        end
      end
      
      sss.subspec 'BXPInfoContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPInfoContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BXPInfoContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPInfoContentPage/Model/**'
        end
      end
      
      sss.subspec 'BXPTagContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPTagContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BXPTagContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPTagContentPage/Model/**'
        end
      end
      
      sss.subspec 'BXPTHContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPTHContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/BXPTHContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/BXPTHContentPage/Model/**'
        end
      end
      
      sss.subspec 'MKPirContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/MKPirContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/MKPirContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/MKPirContentPage/Model/**'
        end
      end
      
      sss.subspec 'MKTofContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/MKTofContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/MKTofContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/MKTofContentPage/Model/**'
        end
      end
      
      sss.subspec 'OtherTypeContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/OtherTypeContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/OtherTypeContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/OtherTypeContentPage/Model/**'
        end
        ssss.subspec 'View' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/OtherTypeContentPage/View/**'
        end
      end
      
      sss.subspec 'TLMContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/TLMContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/TLMContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/TLMContentPage/Model/**'
        end
      end
      
      sss.subspec 'UIDContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/UIDContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/UIDContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/UIDContentPage/Model/**'
        end
      end
      
      sss.subspec 'URLContentPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/URLContentPage/Controller/**'
          sssss.dependency 'MKLoRaWAN-AF/Functions/PayloadContentSelections/URLContentPage/Model'
        end
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PayloadContentSelections/URLContentPage/Model/**'
        end
      end
      
    end
    
    ss.subspec 'PeriodicImmediatelyPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PeriodicImmediatelyPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/PeriodicImmediatelyPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PeriodicImmediatelyPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PeriodicScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/PeriodicScanPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PeriodicScanPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicTimingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PeriodicTimingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/PeriodicTimingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/PeriodicTimingPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'ScanAlwaysPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanAlwaysPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanAlwaysPage/Model'
                
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanAlwaysPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'ScanReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanReportPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanReportPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/TimingImmediatelyPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/PeriodicImmediatelyPage/Controller'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanAlwaysPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/PeriodicScanPage/Controller'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimingPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/TimingReportPage/Controller'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/PeriodicTimingPage/Controller'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanReportPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanTimingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanTimingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/ScanTimingPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/SelftestPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/SelftestPage/View'
        ssss.dependency 'MKLoRaWAN-AF/Functions/SelftestPage/Model'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/SelftestPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'SynDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/SynDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/SynDataPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/SynDataPage/View/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/BleGatewaySettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-AF/Functions/DeviceSettingsPage/Controller'
      end
    end
    
    ss.subspec 'THSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/THSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/THSettingsPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/THSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'TimingImmediatelyPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/TimingImmediatelyPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/TimingImmediatelyPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/TimingImmediatelyPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'TimingReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/TimingReportPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/TimingReportPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/TimingReportPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AF/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AF/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-AF/SDK'
    ss.dependency 'MKLoRaWAN-AF/DatabaseManager'
    ss.dependency 'MKLoRaWAN-AF/CTMediator'
    ss.dependency 'MKLoRaWAN-AF/ConnectModule'
    ss.dependency 'MKLoRaWAN-AF/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKFilterPagesModule'
    
    
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary',    '4.13.0'
    
  end

end
