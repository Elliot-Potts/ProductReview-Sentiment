function data = readLexiconFiles
%READLEXICONFILES readLexiconFiles
%   MATLAB function to load the lexicon files from Hu and Liu.

% Load the positive opinion lexicon file.
getPositiveWords = fopen(fullfile('opinion-lexicon-English','positive-words.txt'));
getComments = textscan(getPositiveWords,'%s','CommentStyle',';');
PositiveWords = string(getComments{1});

% Load the negative opinion lexicon file.
getNegativeWords = fopen(fullfile('opinion-lexicon-English','negative-words.txt'));
getComments = textscan(getNegativeWords,'%s','CommentStyle',';');
NegativeWords = string(getComments{1});

% Create positive / negative table
WordsTable = [PositiveWords;NegativeWords];
WordsTableLabels = categorical(nan(numel(WordsTable),1));
WordsTableLabels(1:numel(PositiveWords)) = "Positive";
WordsTableLabels(numel(PositiveWords)+1:end) = "Negative";

% Provide function return type.
data = table(WordsTable,WordsTableLabels,'VariableNames',{'Word','Label'});
end

