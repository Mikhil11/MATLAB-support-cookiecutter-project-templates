% % rootDir = pwd();
% % FunctionFileInfo = dir(fullfile(rootDir,"code","*.mlx"));
% % FunctionFileInfo1 = dir(fullfile(rootDir,"code","*.m"));
% % allFiles= vertcat(FunctionFileInfo,FunctionFileInfo1);
% % filesToCheck = fullfile(string({allFiles.folder}'),string({allFiles.name}'));
% % testFileInfo = fullfile(rootDir,"test","Test_parameters.txt");
% % fid = fopen(testFileInfo,'w');
% % for i=1:length(allFiles)
% %     a = string(allFiles(i).name);
% %     FunName = strsplit(a,'.');
% %     fprintf(fid, '%s:\n', FunName(1));
% %     fprintf(fid, 'Input parameter:\n');
% %     fprintf(fid, 'Expected Output:\n');
% % end
% % fclose(fid);
% 
% % get the current directory and read the test file
% rootDir = pwd();
% testFileInfo = fullfile(rootDir,"test","Test_parameters.txt");
% fid = fopen(testFileInfo,'rt');
% tline = readlines(testFileInfo);
% tline = tline(string(tline)~="");
% FName = [];FInput = [];FOutput = [];
% for i=1:length(tline)
%     a_split = strsplit(tline(i),':');
%     disp(a_split);
%     if strcmp(a_split(1),"Input parameter")
%         FInput = [FInput a_split(2)];
%     elseif strcmp(a_split(1),"Expected Output")
%         FOutput = [FOutput a_split(2)];
%     else
%         FName = [FName a_split(1)];
%     end
% end
% % FInput = FInput(string(FInput)~="");
% % FOutput = FOutput(string(FOutput)~="");
% % FName = FName(string(FName)~="");
% 

rootDir = pwd();
testFileInfo = dir(fullfile(rootDir,"code"));




