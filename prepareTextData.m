function documents = prepareTextData(text_data)
% Tokenize the inputted text data.
documents = tokenizedDocument(text_data);

% Erase punctuation from inputted text data.
documents = erasePunctuation(documents);

% Remove a list of stop words from the inputted text.
documents = removeStopWords(documents);

% Convert all text in input dataset to lowercase.
documents = lower(documents);
end