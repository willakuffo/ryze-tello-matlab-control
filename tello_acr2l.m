
clear;clc;
tc = TelloControl;



tc.initTello();
tc.getTelloState()
tc.cmdTello('takeoff');
%pause(1);

tc.cmdTello('rc 0 0 -100 0');

%tc.getCameraFeed()
%tc.cmdTello('takeoff')
%pause(1)
%tc.cmdTello('rc 0 30 0 100');
% %tc.cmdTello('cw 180')
%  tc.cmdTello('forward 60')
%  tc.cmdTello('cw 90')
%  tc.cmdTello('forward 60')
%  tc.cmdTello('cw 90')
%  tc.cmdTello('flip b')
% tc.cmdTello('forward 60')
%  tc.cmdTello('cw 90')
%  tc.cmdTello('forward 60')
%  tc.cmdTello('cw 90')
% 
% tc.cmdTello('land')


%d = ryze
%tc.getCameraFeed()
%tc.getCameraFeed()
%tc.getCameraFeed()

%response = tc.cmdTello('takeoff');

%if strcmp(response,'ok') % after acknowledgement that former command has finished executing
%tc.cmdTello('forward 100');
%tc.getTelloState()

%tc.cmdTello('cw 90');
%tc.getTelloState()
%tc.cmdTello('land');

%end

% if strcmp(response,'ok')
%     write(telloSDKClient,"go 40 100 40 100","string",telloIP,telloSDKPort);
% responsec = read(telloSDKClient,2,'string');
%  fprintf('%s :CMD: cw 360\n',responsec);
%  if strcmp(responsec,'ok')
%     write(telloSDKClient,"land","string",telloIP,telloSDKPort);
% responsec = read(telloSDKClient,2,'string');
%  fprintf('%s :CMD: land\n',responsec);
%  end
% end
% end

  
% 
% write(telloClient,"cw 3600","string",telloIP,telloSDKPort);
% response = readline(telloClient)
% 
% write(telloClient,"land","string",telloIP,telloSDKPort);f - 
% response = readline(telloClient)
% write(telloClient,"land","string",telloIP,telloSDKPort);
% response = readline(telloClient)
% 
% 
% 
% 
% 
% 
% %response = readline(telloClient,10,'string')
% 
% pause(0.5)
% fprintf('listening for tello state on PORT : %d ...',telloDroneStatePort)
%  %listen tello drone state
% for i = 1:100
%  readline(telloStateClient)
% pause(0.1)
%  
%  
% end