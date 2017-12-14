%% Load Pretrained AlexNet Convolutional Neural Network
% Load a pretrained AlexNet convolutional neural network and examine the
% layers and classes.

%%
% Load the pretrained AlexNet network using |alexnet|. The output |net| is
% a |SeriesNetwork| object.
net = alexnet

%%
% Using the |Layers| property, view the network architecture. The network
% comprises of 25 layers. There are 8 layers with learnable weights: 5
% convolutional layers, and 3 fully connected layers.
net.Layers

%%
% You can view the names of the classes learned by the network by viewing
% the |ClassNames| property of the classification output layer (the final
% layer). View the first 10 classes by selecting the first 10 elements.
net.Layers(end).ClassNames(1:10)