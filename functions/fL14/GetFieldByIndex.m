function Data = GetFieldByIndex(S, n)
%it is a function to access structure fields via numerical indexes
%instead of name field

fields    = fieldnames(S);
Data = S.(fields{n});