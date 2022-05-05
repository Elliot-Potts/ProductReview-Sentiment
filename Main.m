% MATLAB files for KF4052. 
% W20017851. Sentiment Analysis of Amazon Reviews.


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







