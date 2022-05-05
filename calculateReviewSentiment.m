% KF4052. W20017851. Gather input data and begin sentiment analysis.

set_filename = "amazon_reviews.txt";
make_table = readtable(set_filename,'TextType','string');
text_data = make_table.review;
text_data(1:10)



