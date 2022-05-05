% KF4052. W20017851. Setup a support vector machine classifier.

% Load the FastText word embedding from the toolkit.
word_embedding = fastTextWordEmbedding;

% Load the opinion lexicons.
lexicon_data = readLexiconFiles;

% Display positive words
% lex1 = lexicon_data.Label == "Positive";
% disp("Showing positive head.");
% head(lexicon_data(lex1,:))

% Remove all words which aren't found in the word embedding (word_embedding).
get_embedding_words = ~isVocabularyWord(word_embedding,lexicon_data.Word);
lexicon_data(get_embedding_words,:) = [];

% Save 10% (0.1) of the lexicon words for testing purposes.
number_of_words = size(lexicon_data,1);
partition = cvpartition(number_of_words,'HoldOut',0.1);
train_data = lexicon_data(training(partition),:);
test_data = lexicon_data(test(partition),:);

% Now take the data and convert words to vectors.
train_words = train_data.Word;
trainX = word2vec(word_embedding,train_words);
trainY = train_data.Label;

% Begin training a Support Vector Machine classifier
% for assigning word vectors to classes.

model = fitcsvm(trainX,trainY);

% Test the newly made SVM classifier.
test_words = test_data.Word;
testX = word2vec(word_embedding,test_words);
testY = test_data.Label;

% Use the previously created SVM model (model) to predict test vectors.
[predictionY,scores] = predict(model,testX);


% Code below is used for viewing the predictions of sentiment data from the
% positive and negative lexicons.

% 'confusionchart' which shows predicted values and the test values.
% Confusionchart shows predicted values against true class values.
figure
confusionchart(testY,predictionY);

% Load wordclouds of Positive and Negative sentiment from lexicons.
figure
subplot(1,2,1)
positive_x = predictionY == "Positive";
wordcloud(test_words(positive_x),scores(positive_x,1));
title("Pos. Sentiment - Lexicon Prediction")

% Load Negative predictions using boolean NOT operator (~).
subplot(1,2,2)
wordcloud(test_words(~positive_x),scores(~positive_x,2));
title("Neg. Sentiment - Lexicon Prediction")