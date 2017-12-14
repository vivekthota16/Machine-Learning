function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%
M=X*Theta'; %vectorized form for predicted ratings, see slides for collaborative filtering
J=(1/2)*sum(sum(((M-Y).*R).^2)); %cost function


%add regularization

J = J + (lambda/2) * sum(sum(Theta .^ 2)) + (lambda/2) * sum(sum(X .^ 2));

%now let's try to use a vectorized implementation to compute the gradient w.r.t. to X and Theta

for i=1:num_movies,
	idx=find(R(i,:)==1); %here I get a  vector with the indices of values = 1, that is I get the users who voted movie i
	Theta_temp=Theta(idx,:);
	Y_temp=Y(i,idx);
	X_grad(i,:)=(X(i,:)*Theta_temp' - Y_temp)*Theta_temp; 
	%add regularization

	X_grad(i,:) = X_grad(i,:) + lambda*X(i,:);

end





for j=1:num_users,
	idx=find(R(:,j)==1); %find the movies that user j has rated
	X_temp=X(idx,:); %r x numfeatures
	Y_temp=Y(idx,j); %r x 1 
	Theta_grad(j,:)=(X_temp*Theta(j,:)' - Y_temp)'*X_temp;  %note the transpose 
	%add regularization
	Theta_grad(j,:)=Theta_grad(j,:) + lambda*Theta(j,:);

end
% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
