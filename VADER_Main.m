% MATLAB files for KF4052. 
% W20017851. Sentiment Analysis of Amazon Reviews.
% Using the VADER Classifier.


% Get data from text file and import to Matlab.
review_filename = "amazon_reviews.txt";
vdr_make_table = readtable(review_filename,'TextType','string');
head(vdr_make_table)

% Make array of tokenized documents.
string = vdr_make_table.review;
vdr_get_documents = tokenizedDocument(string);
vdr_get_documents(1:5)

% Use VADER Classifier to evaluate sentiment of each token.
% Scores which are close to 1 resemble positive sentiment, 0 represents a
% neutral sentiment and -1 represents negative sentiment.
vdr_compound_scores = vaderSentimentScores(vdr_get_documents);
vdr_compound_scores(1:5)

% Make word clouds
vdr_posx = vdr_compound_scores > 0;
string_positive = string(vdr_posx);
string_negative = string(~vdr_posx);  % get opposite of string_positive

disp("VDR POSX");
string_positive;
disp("VDR NEGX");
string_negative;

figure
subplot(1,2,1)
wordcloud(string_positive);
title("VADER Pos. Sentiment - Reviews")

subplot(1,2,2)
wordcloud(string_negative);
title("VADER Neg. Sentiment - Reviews")