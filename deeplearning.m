camera = webcam('DroidCam Source 3');                           % Connect to camera
nnet = alexnet;                            % Load neural net
while true  
    picture = snapshot(camera);            % Take picture
    picture = imresize(picture,[227,227]); % Resize
    label = classify(nnet, picture);       % Classify 
    image(picture);                        % Show picture
    title(char(label));                   % Show label
    drawnow;   
end