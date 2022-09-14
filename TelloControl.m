classdef TelloControl
    properties
        telloSDKPort;
        
        telloDroneStatePort;
        
        telloIP;
        localhost;
        telloSDKClient;
        telloStateClient;
        telloCameraClient;
        telloCameraPort;
        telloState;
    end

    methods
        function self = TelloControl()
            self.telloSDKPort = 8889;

            self.telloDroneStatePort = 8890;
            self.telloCameraPort = 11111;
            self.telloState = {};
            
            self.telloIP = '192.168.10.1';
            self.localhost = '0.0.0.0';
            self.telloSDKClient = udpport("LocalHost",self.localhost,"LocalPort",self.telloSDKPort);
            self.telloStateClient = udpport("LocalHost",self.localhost,"LocalPort",self.telloDroneStatePort);
            self.telloCameraClient = udpport("LocalHost",self.localhost,"LocalPort",self.telloCameraPort);
            %configureMulticast(u,"226.0.0.1");

            
        end


        function initTello(self)
            %initialize sdk if fails - add retries - after retries, reset drone on/off
            disp('initializing RYZE TELLO SDK...')
            write(self.telloSDKClient,"command","string",self.telloIP,self.telloSDKPort);
            response = read(self.telloSDKClient,2,'string');
            
            
            if strcmp(response,'ok')
                fprintf('%s: SDK initialization successful on IP: %s at PORT: %d\n',response,self.telloIP,self.telloSDKPort)
            else
                disp('error: SDK initialization failed')
            end
        end


        function response =  cmdTello(self,command)
             write(self.telloSDKClient,command,"string",self.telloIP,self.telloSDKPort);

            if ~contains(command,'rc') %rc channel does not respond in ack - so only read resonse when command is not rc
             response = read(self.telloSDKClient,2,'char');
             disp(self.telloSDKClient.NumBytesAvailable)
             %retry 2 more times if error
             if ~strcmp(response,'ok')  
                 for retries = 1:2
                    write(self.telloSDKClient,command,"string",self.telloIP,self.telloSDKPort);
                    response = read(self.telloSDKClient,2,'char');
                    fprintf('retries: %d %s :CMD: %s\n',retries,response,command);
                
                 if strcmp(response,'ok')
                    break


%                 elseif ~strcmp(response,'ok') &&  (retries == 2)
%                     warning('With retries: %d %s :CMD: %s failed. Skipping CMD \n',retries,response,command);
%                     break

                 end                
                 end
             end
             if contains(command,'rc')
                  fprintf('CMD: %s\n',command);
             else

                 fprintf('%s :CMD: %s\n',response,command);
             end

            %end
        end


        function telloStat =  getTelloState(self)
             %write(self.telloStateClient,command,"string",self.telloIP,self.telloSDKPort);
             state = readline(self.telloStateClient);
             %fprintf('%s :CMD: %s\n',command);
             pre1 = split(state,';');
             pre2 = split(pre1(1:16),':');
             for i = 1:length(pre2) %update tllo state
                 self.telloState.(pre2(i,1)) = str2double(pre2(i,2));
             end
             telloStat = self.telloState;
        end

        function stream = getCameraFeed(self)
            self.cmdTello('streamon');
            %udpaddress = strcat('udp://@',char(self.telloCameraClient.LocalHost),':',num2str(self.telloCameraClient.LocalPort));
            %disp(udpaddress)
            %stream = imread(udpaddress)
            %stream = fread(self.telloCameraClient);
            %stream = read(self.telloCameraClient,720*960*3);
            udp = sprintf('udp://@%s:%s',self.telloCameraClient.LocalHost,num2str(self.telloCameraClient.LocalPort))
            disp(udp)
            
            %imread(udp)
            %cap = py.cv2.VideoCapture(udp)
            %cap.open(udp)
            for i = 0:20
            cap.read()
            end
        end

    end
   
            

   


end