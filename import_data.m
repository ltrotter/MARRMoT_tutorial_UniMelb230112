function data = import_data(filename)
%%% Author: Luca Trotter (modified from MATLAB auto-generated script)
%%% Date: 03/08/2020 edited 2023/01 
%%% Description:
%       Imports data from CSV file in my own format

%% Initialize variables.
delimiter = ',';
startRow = 2;
endRow = inf;

%% Format for each line of text:
%   column1: datetimes (%{yyyy-MM-dd}D)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%	column7: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%{yyyy-MM-dd}D%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Create output variable
data = table(dataArray{1:end-1}, 'VariableNames', {'time','pet','temp_max','temp_min','precip','Q_obs_ML','Q_obs','qual'});
