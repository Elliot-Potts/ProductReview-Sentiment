% KF4052. W20017851. Gather input data and begin sentiment analysis.

% Import dataset and create table in Matlab.
set_filename = "amazon_reviews.txt";
make_table = readtable(set_filename,'TextType','string');
text_data = make_table.review;
text_data(1:10)

% Prepare inputted data for use in SVM classifier.
input_documents = prepareTextData(text_data);
% Remove words not found in the word embedding, as they will have no
% effect.
keep_embeddings_only = ~isVocabularyWord(word_embedding,input_documents.Vocabulary);
input_documents = removeWords(input_documents,keep_embeddings_only);

disp("Loading Sentiment Analysis Wordclouds for Amazon Review Data.");

% Get words from the newly prepared text data.
get_words = input_documents.Vocabulary;
get_words(ismember(get_words,train_words)) = [];

% Convert words to word vectors for use with SVM.
make_input_vectors = word2vec(word_embedding,get_words);
% Make predictions using the SVM classifier.
[input_predictionY,input_scores] = predict(model,make_input_vectors);

% Generate Amazon review wordclouds.
figure
subplot(1,2,1)
input_positive_x = input_predictionY == "Positive";
fprintf("SVM Review Positive - Min Sentiment: %d,Max Sentiment: %d\n", min(input_scores(input_positive_x)), max(input_scores(input_positive_x)));
wordcloud(get_words(input_positive_x),input_scores(input_positive_x,1));
title("Pos. Sentiment - Review Prediction")

subplot(1,2,2)
fprintf("SVM Review Negative - Min Sentiment: %d,Max Sentiment: %d\n", min(input_scores(~input_positive_x)), max(input_scores(~input_positive_x)));
wordcloud(get_words(~input_positive_x),input_scores(~input_positive_x,2));
title("Neg. Sentiment - Review Prediction")


