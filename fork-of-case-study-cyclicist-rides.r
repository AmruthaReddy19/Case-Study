{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/poluamrutha/fork-of-case-study-cyclicist-rides?scriptVersionId=144931802\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown"},{"cell_type":"markdown","source":"#### Cyclistic : How Does a Bike-Share Navigate Speedy Success?\n\nInitial R code source:\nThis analysis is for case study 1 from the Google Data Analytics Certificate (Cyclistic). It is originally based on the case study https://artscience.blog/home/divvy-dataviz-case-study written by Kevin Hartman. The R code has been adapted for use with updated data and file formats.","metadata":{"_uuid":"4f04a650-4d9e-4f30-a9f5-b102280ddaab","_cell_guid":"7fc594aa-ae3a-4154-920c-d5d942112277","trusted":true}},{"cell_type":"markdown","source":"#### Install and load necessary packages","metadata":{"_uuid":"2a9b20aa-a010-462b-863a-abb81c4b2d8b","_cell_guid":"2257fb5e-1460-4528-8725-05136dfed2af","trusted":true}},{"cell_type":"code","source":"install.packages('tidyverse')","metadata":{"_uuid":"985fa0f5-3cee-4ea0-8153-9a60960cfc12","_cell_guid":"23b68556-fb11-4c68-9aff-e5a0a3c2b3ea","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:15:40.172303Z","iopub.execute_input":"2023-10-01T20:15:40.174202Z","iopub.status.idle":"2023-10-01T20:15:54.39717Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"install.packages('lubridate')","metadata":{"_uuid":"c292ad81-6fe2-42b6-8e3c-92ce6f6dfee6","_cell_guid":"547dd8bc-95b1-4730-bf98-e128e28567a0","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:15:54.40012Z","iopub.execute_input":"2023-10-01T20:15:54.435301Z","iopub.status.idle":"2023-10-01T20:16:06.426281Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"install.packages('hms')","metadata":{"_uuid":"4357ccb9-940d-44b8-85b9-d150be08228a","_cell_guid":"874f6c86-9463-4c26-9497-70b54b330a10","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:16:06.428449Z","iopub.execute_input":"2023-10-01T20:16:06.429548Z","iopub.status.idle":"2023-10-01T20:16:13.135389Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"install.packages('data.table')","metadata":{"_uuid":"97e1db7f-f0c7-4662-a9ab-bd123be2a324","_cell_guid":"5137ed71-a23e-4359-8e22-5336ea3e5ae0","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:16:13.138601Z","iopub.execute_input":"2023-10-01T20:16:13.139688Z","iopub.status.idle":"2023-10-01T20:16:38.559978Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"install.packages(\"modeest\")","metadata":{"_uuid":"26e7690f-f2e1-473e-b1f6-c2b0b0d4df58","_cell_guid":"fb1bc8b3-d336-417a-8554-2e79b8d715cf","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:16:38.561856Z","iopub.execute_input":"2023-10-01T20:16:38.562809Z","iopub.status.idle":"2023-10-01T20:16:47.222597Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"install.packages(\"openxlsx\")","metadata":{"_uuid":"e777c21e-4347-4cd6-85f7-5431bf3db12a","_cell_guid":"168d2765-8a70-43d7-85d9-8a21f1230f1e","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:16:47.225592Z","iopub.execute_input":"2023-10-01T20:16:47.226701Z","iopub.status.idle":"2023-10-01T20:17:56.970797Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"library(dplyr)\nlibrary(ggplot2)\nlibrary(modeest)","metadata":{"_uuid":"0486fcaf-aea2-4780-9df1-2ee10a6eb4e9","_cell_guid":"4698cdc4-a1f9-45b0-a05d-8c32c009aa2e","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:17:56.972765Z","iopub.execute_input":"2023-10-01T20:17:56.973794Z","iopub.status.idle":"2023-10-01T20:17:57.477505Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"#load libraries \nlibrary(tidyverse) #calculations\nlibrary(lubridate) #dates \nlibrary(hms) #time\nlibrary(data.table)","metadata":{"_uuid":"9af2e775-fa32-46c0-8c68-8738dd830531","_cell_guid":"8de30664-cb70-49fe-8250-c9e1e81ce745","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:17:57.479484Z","iopub.execute_input":"2023-10-01T20:17:57.480744Z","iopub.status.idle":"2023-10-01T20:17:57.940519Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"library(openxlsx)","metadata":{"_uuid":"56338ccf-4715-49d5-b1d4-c7d42374fb7e","_cell_guid":"0abc5d48-0344-48c5-92dc-17e6dd6c4697","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:17:57.94234Z","iopub.execute_input":"2023-10-01T20:17:57.943604Z","iopub.status.idle":"2023-10-01T20:17:58.036233Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"","metadata":{"_uuid":"9ce04c75-3844-4a77-a409-5534f97129e0","_cell_guid":"bb96e1ba-23ef-478e-b702-9f3018795996","collapsed":false,"jupyter":{"outputs_hidden":false},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"#### Ask\n###### Indentify the business task\nThe key business task in this case is to discover how casual riders and Cyclistic members use their rental bikes differently. Both the Director of Marketing as well as finance analysts have concluded that annual members are more profitable.\n\nTherefore, the results of this analysis will be used to design a new marketing strategy to convert casual riders to annual members.\n\n###### Consider key stakeholders.\nKey stakeholders include: Cyclistic executive team, Director of Marketing (Lily Moreno), Marketing Analytics team.","metadata":{"_uuid":"16f916af-aa17-4f61-bd08-f7df9443c38c","_cell_guid":"00555848-617e-4e27-a9ba-4473be5d0da6","trusted":true}},{"cell_type":"markdown","source":"#### Prepare\nDownload data and store it appropriately.\nData has been downloaded from Motivate International Inc. Local copies have been stored securely on Google Drive and here on Kaggle.\n\nIdentify how it’s organized.\nAll trip data is in comma-delimited (.CSV) format with 15 columns, including: ride ID #, ride type, start/end time, ride length (in minutes), day of the week, starting point (code, name, and latitude/longitude), ending point (code, name, and latitude/longitude), and member/casual rider.\n\nDetermine the credibility of the data.\nDue to the fact that this is a case study using public data, we are going to assume the data is credible.\n\n#### Process\nCheck the data for errors.\nThe code chunk below will import 12 individual .xlsx files as data frames, each representing 1 of the last 12 months of trip data. Some parsing errors persist, however, they represent less 0.25% of the data set, so this is still a representative sample.","metadata":{"_uuid":"8e3cde27-3dd9-46bf-9e3f-ffb6f8a6d049","_cell_guid":"371fa6f0-ac29-4846-9f13-c323f17ddbec","trusted":true}},{"cell_type":"code","source":"y2022_08 <- read.csv('/kaggle/input/case-study-cyclicist/case study/aug22.csv')","metadata":{"_uuid":"5b369866-24c0-43ad-99a5-1960f8003ba6","_cell_guid":"470aff0e-739d-449c-9dd3-6a717649a150","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:17:58.038159Z","iopub.execute_input":"2023-10-01T20:17:58.039386Z","iopub.status.idle":"2023-10-01T20:18:11.45844Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2022_09 <- read.csv('/kaggle/input/case-study-cyclicist/case study/sep22.csv')","metadata":{"_uuid":"814418cf-89ea-48bf-8048-e01e03b0bf6e","_cell_guid":"72ea3d95-4ba0-4ad6-8051-9f5a66afdf6d","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:11.460331Z","iopub.execute_input":"2023-10-01T20:18:11.4615Z","iopub.status.idle":"2023-10-01T20:18:21.352376Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2022_10 <- read.csv('/kaggle/input/case-study-cyclicist/case study/oct22.csv')","metadata":{"_uuid":"5306f41e-46aa-4e81-bc0f-347fdc86919b","_cell_guid":"1c2f3f86-1e92-4319-9566-2998dc001f8a","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:21.354319Z","iopub.execute_input":"2023-10-01T20:18:21.355403Z","iopub.status.idle":"2023-10-01T20:18:30.587693Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2022_11 <- read.csv('/kaggle/input/case-study-cyclicist/case study/nov22.csv')","metadata":{"_uuid":"23536f9e-3ae8-4c47-8d86-29fa7b320444","_cell_guid":"daa7d71b-a997-4409-90e8-b1e034001eef","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:30.589636Z","iopub.execute_input":"2023-10-01T20:18:30.590551Z","iopub.status.idle":"2023-10-01T20:18:38.464988Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2022_12 <- read.csv('/kaggle/input/case-study-cyclicist/case study/dec22.csv')","metadata":{"_uuid":"38d143b0-ff4d-403b-b16e-4acc6afaab47","_cell_guid":"3446f407-03e0-484a-8239-4017c85eb961","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:38.468128Z","iopub.execute_input":"2023-10-01T20:18:38.469172Z","iopub.status.idle":"2023-10-01T20:18:43.54888Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_01 <- read.csv('/kaggle/input/case-study-cyclicist/case study/jan23.csv')","metadata":{"_uuid":"7901aef5-bcb5-4ac0-bd6f-2cec5489ab77","_cell_guid":"7d06bd55-e246-4b55-8b37-e9b3485f98e4","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:43.551956Z","iopub.execute_input":"2023-10-01T20:18:43.553001Z","iopub.status.idle":"2023-10-01T20:18:45.152855Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_02 <- read.csv('/kaggle/input/case-study-cyclicist/case study/feb 23.csv')","metadata":{"_uuid":"454d431c-1bd1-4171-81f8-e2065a73c755","_cell_guid":"48ea7a8f-92fd-4abf-9217-6d64d4b45488","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:45.155319Z","iopub.execute_input":"2023-10-01T20:18:45.157033Z","iopub.status.idle":"2023-10-01T20:18:50.440516Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_03 <- read.csv('/kaggle/input/case-study-cyclicist/case study/march23.csv')","metadata":{"_uuid":"62a23b37-37d7-4cbb-9619-587c96e4e8b5","_cell_guid":"d30c78b5-2f33-46c8-a286-bb9c9d59e0ad","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:50.442961Z","iopub.execute_input":"2023-10-01T20:18:50.44399Z","iopub.status.idle":"2023-10-01T20:18:54.554763Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_04 <- read.csv('/kaggle/input/case-study-cyclicist/case study/apr23.csv')","metadata":{"_uuid":"55a19d42-9cd8-4b58-83e2-71ae2a69a13c","_cell_guid":"cc930857-afcf-4e5a-99e1-291b1c55fc86","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:54.556447Z","iopub.execute_input":"2023-10-01T20:18:54.557315Z","iopub.status.idle":"2023-10-01T20:18:56.501895Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_05 <- read.csv('/kaggle/input/case-study-cyclicist/case study/may 23.csv')","metadata":{"_uuid":"cc4374ad-1834-4294-9f00-d214dce79009","_cell_guid":"0acb29bc-3e77-4825-965e-3d726520d91e","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:18:56.503693Z","iopub.execute_input":"2023-10-01T20:18:56.504663Z","iopub.status.idle":"2023-10-01T20:19:01.953389Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_06 <- read.csv('/kaggle/input/case-study-cyclicist/case study/june23.csv')","metadata":{"_uuid":"47186370-94c6-4a4b-8112-2bdd8f45d1c3","_cell_guid":"53eee050-e4b2-4e58-954a-1adfe6d76083","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:01.956362Z","iopub.execute_input":"2023-10-01T20:19:01.957385Z","iopub.status.idle":"2023-10-01T20:19:11.348879Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"y2023_07<- read.csv('/kaggle/input/case-study-cyclicist/case study/july23.csv')","metadata":{"_uuid":"251d1661-b232-449c-ade9-1ea76eb14b9b","_cell_guid":"3093e315-64cc-418b-9ab9-ece62d1eb8f4","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:11.350994Z","iopub.execute_input":"2023-10-01T20:19:11.352363Z","iopub.status.idle":"2023-10-01T20:19:22.44603Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"1 column was added to each of the 12 monthly .CSV files:\n\nDay of the week (1 = Sunday, 7 = Saturday)","metadata":{"_uuid":"d2797ec2-9550-4f3f-94f0-8072ae7ad8f9","_cell_guid":"72792bd1-b0e1-4238-9d41-682b931405d8","trusted":true}},{"cell_type":"code","source":"#calculate the day of the week \ny2022_08 $day_of_week <- wday(y2022_08 $started_at)\ny2022_09 $day_of_week <- wday(y2022_09 $started_at)\ny2022_10 $day_of_week <- wday(y2022_10 $started_at)\ny2022_11 $day_of_week <- wday(y2022_11 $started_at)\ny2022_12 $day_of_week <- wday(y2022_12 $started_at)\ny2023_01 $day_of_week <- wday(y2023_01 $started_at)\ny2023_02 $day_of_week <- wday(y2023_02 $started_at)\ny2023_03 $day_of_week <- wday(y2023_03 $started_at)\ny2023_04 $day_of_week <- wday(y2023_04 $started_at)\ny2023_05 $day_of_week <- wday(y2023_05 $started_at)\ny2023_06 $day_of_week <- wday(y2023_06 $started_at)\ny2023_07 $day_of_week <- wday(y2023_07 $started_at)","metadata":{"_uuid":"e1d652df-5c49-4531-ba2b-7c72da236e72","_cell_guid":"103c6f93-d05e-4c0f-92da-a8f030142e9e","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:22.447932Z","iopub.execute_input":"2023-10-01T20:19:22.449053Z","iopub.status.idle":"2023-10-01T20:19:29.977572Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"head(y2022_08)","metadata":{"_uuid":"27736e5f-7e4a-42d3-81ef-804b3e7ee3f2","_cell_guid":"555cf799-2e64-4576-952b-909b7f0b25ef","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:29.9794Z","iopub.execute_input":"2023-10-01T20:19:29.980368Z","iopub.status.idle":"2023-10-01T20:19:30.008258Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"#### Document the cleaning process.\n\n\nDay of the week (1 = Sunday, 7 = Saturday) column is added in to the all 12 \nCSV files.","metadata":{"_uuid":"0652af07-5246-4018-85a5-8a4f462a5e2c","_cell_guid":"40fe724e-1b37-40e2-ab7a-4b224875c09f","trusted":true}},{"cell_type":"markdown","source":"#### Analyze\nAggregating data so it’s useful and accessible.\nThis code chunk will combine the 12 individual data frames into one large data frame for analysis.","metadata":{"_uuid":"24d4bbee-0768-41f3-8d16-997e79e9f0bc","_cell_guid":"a1affcf1-f5e7-4e1a-9f65-57b4e0b5ce28","trusted":true}},{"cell_type":"code","source":"all_trips_init <- bind_rows(\n                       y2022_08, \n                       y2022_09, \n                       y2022_10, \n                       y2022_11, \n                       y2022_12, \n                       y2023_01, \n                       y2023_02, \n                       y2023_03, \n                       y2023_04, \n                       y2023_05, \n                       y2023_06, \n                       y2023_07, \n                       )","metadata":{"_uuid":"61d42092-2bbc-4077-adb3-ae0fb74c648b","_cell_guid":"b2654dd1-bb70-4c44-989b-940b311677e6","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:30.009964Z","iopub.execute_input":"2023-10-01T20:19:30.010953Z","iopub.status.idle":"2023-10-01T20:19:32.806543Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"head(all_trips_init)","metadata":{"_uuid":"f0cd5590-2f35-490e-9ed7-19cd4b79fee7","_cell_guid":"5764bae9-153c-461c-84fc-ec2146dc925c","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:32.808357Z","iopub.execute_input":"2023-10-01T20:19:32.809334Z","iopub.status.idle":"2023-10-01T20:19:32.831754Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Next, we add columns to list the date, month, day, and year of each ride for additional aggregation capabilities.","metadata":{"_uuid":"bafff2eb-972a-4690-b4d0-53d31a13c5a0","_cell_guid":"1f273adb-6795-42d2-a7c6-d5f4cc06abea","trusted":true}},{"cell_type":"code","source":"## ----Add columns that list the date, month, day, and year of each ride for additional aggregation----\nall_trips_init$date <- as.Date(all_trips_init$started_at)\nall_trips_init$month <- format(as.Date(all_trips_init$date), \"%m\")\nall_trips_init$day <- format(as.Date(all_trips_init$date), \"%d\")\nall_trips_init$year <- format(as.Date(all_trips_init$date), \"%Y\")\nall_trips_init$day_of_week <- format(as.Date(all_trips_init$date), \"%A\")","metadata":{"_uuid":"7c493044-b537-4879-b853-1829a7107995","_cell_guid":"f0e1c589-cd87-4679-86a1-04793ad09ed4","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:32.833521Z","iopub.execute_input":"2023-10-01T20:19:32.834424Z","iopub.status.idle":"2023-10-01T20:19:55.425478Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"head(all_trips_init)","metadata":{"_uuid":"f0a05a70-0936-4383-a792-488a5f88b11f","_cell_guid":"7bd00ec1-8c6a-4129-8617-7ab4984b0f31","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:55.427237Z","iopub.execute_input":"2023-10-01T20:19:55.428138Z","iopub.status.idle":"2023-10-01T20:19:55.4543Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"We also remove any unnecessary columns (erroneous ride_length, latitude/longitude fields).","metadata":{"_uuid":"b137095d-8fe7-4a5c-8729-22a51443bfb5","_cell_guid":"9b7831bd-c69e-4c73-b007-f7bfcb37babd","trusted":true}},{"cell_type":"code","source":"all_trips_init <- all_trips_init %>% \n  select(-c( start_lat, start_lng, end_lat, end_lng))","metadata":{"_uuid":"8a8aafd6-11d3-44db-8729-307864f17847","_cell_guid":"ca1078f3-6f22-4a8c-a46d-b9e1804b4184","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:55.455932Z","iopub.execute_input":"2023-10-01T20:19:55.456856Z","iopub.status.idle":"2023-10-01T20:19:55.491454Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"We'll add another column to calculate each ride length in seconds.","metadata":{"_uuid":"b3ac12f8-5d63-4d32-ae74-28e241feb4fb","_cell_guid":"3024ec33-8a81-4f54-a439-897133825a29","trusted":true}},{"cell_type":"code","source":"all_trips_init$ride_length <- as.numeric(difftime(all_trips_init$ended_at,all_trips_init$started_at))","metadata":{"_uuid":"273185e0-f837-457f-b474-2f750ed93051","_cell_guid":"0771e336-232a-4ec4-86a7-412f39404a47","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:19:55.493173Z","iopub.execute_input":"2023-10-01T20:19:55.494093Z","iopub.status.idle":"2023-10-01T20:20:18.097438Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Let's next remove the NA rows.","metadata":{"_uuid":"c10f9ad3-01fb-4e4b-9954-12a04dca75b1","_cell_guid":"edc569f2-669e-478d-a16e-54aefe4339a7","trusted":true}},{"cell_type":"code","source":"all_trips_no_na <- drop_na(all_trips_init)","metadata":{"_uuid":"e3e0d19f-a31d-49f4-9c2e-8c213badb9dc","_cell_guid":"59daf011-b755-462e-b0df-29fb2e541af0","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:18.099569Z","iopub.execute_input":"2023-10-01T20:20:18.100675Z","iopub.status.idle":"2023-10-01T20:20:24.169801Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"null_count <- sum(sapply(all_trips_init, is.null))","metadata":{"_uuid":"f57c8be7-3e3a-42ed-beaa-d4dd6d8a48ac","_cell_guid":"351098c2-0f77-4c12-a651-c4b3f3c316a9","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:24.171863Z","iopub.execute_input":"2023-10-01T20:20:24.172831Z","iopub.status.idle":"2023-10-01T20:20:24.182072Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"print(null_count)","metadata":{"_uuid":"874fb30a-28d2-4f0c-984e-c1b9c914f624","_cell_guid":"567b01a1-510b-43d5-b2cb-d08a1abbf85f","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:24.183866Z","iopub.execute_input":"2023-10-01T20:20:24.184852Z","iopub.status.idle":"2023-10-01T20:20:24.194655Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"The aggregated data frame includes approximately 10,500 entries (0.30% of total rides) when bikes were taken out of docks and checked for quality by Cyclistic or ride_length was negative. We will create a new version of the data frame since data is being removed.","metadata":{"_uuid":"1de85325-ce4d-4171-8c96-d367e80c2b43","_cell_guid":"4db533be-8be3-4006-9d1e-a817c25ae9f6","trusted":true}},{"cell_type":"code","source":"## ----Remove negative ride length and quality check rows---------------------\nall_trips <- all_trips_no_na[!(all_trips_no_na$start_station_name == \"HQ QR\" | all_trips_no_na$ride_length<0),]","metadata":{"_uuid":"035008b3-0707-4e58-844e-017f01ad6692","_cell_guid":"80fc764a-c497-4b9f-9991-4a3523b4ae91","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:24.196553Z","iopub.execute_input":"2023-10-01T20:20:24.197653Z","iopub.status.idle":"2023-10-01T20:20:26.645573Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"str(all_trips)","metadata":{"_uuid":"c3dac089-1baa-445e-90bc-b9ea389490a0","_cell_guid":"229f710b-a1a5-420c-91aa-a2f93c002a05","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:26.647515Z","iopub.execute_input":"2023-10-01T20:20:26.648494Z","iopub.status.idle":"2023-10-01T20:20:26.677549Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Perform calculations.\nLet's first look at a statistical summary of the aggregated and transformed data frame. Let's also look at the structure of the columns.","metadata":{"_uuid":"0904dbcf-ccd8-44e2-8185-cee88d168aff","_cell_guid":"21572114-4fa8-4ba6-8a66-46b611ce7e15","execution":{"iopub.status.busy":"2023-10-01T14:22:54.758614Z","iopub.execute_input":"2023-10-01T14:22:54.759963Z","iopub.status.idle":"2023-10-01T14:22:54.81385Z"},"trusted":true}},{"cell_type":"code","source":"summary(all_trips)\nstr(all_trips)","metadata":{"_uuid":"e33050f2-1d20-4c21-a7cb-6687a76d1a6f","_cell_guid":"1692e881-51a1-4468-a39b-0cf0b2b8f199","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:26.679375Z","iopub.execute_input":"2023-10-01T20:20:26.680333Z","iopub.status.idle":"2023-10-01T20:20:28.21255Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Let's next focus on the average length of each ride, this time in minutes. We see that on average, each ride is close to 30 minutes. We'll then break that down by casual riders versus members.","metadata":{"_uuid":"a2c7d999-0f68-4212-a8cb-ff6fcc59980c","_cell_guid":"1827c7ca-e32a-4bca-a873-39de81b06904","trusted":true}},{"cell_type":"code","source":"","metadata":{"_uuid":"83ff2660-9696-4349-9e73-b2ac9de191c0","_cell_guid":"914ae495-b2df-407b-8100-185f3e66cf5a","collapsed":false,"jupyter":{"outputs_hidden":false},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"summary(all_trips$ride_length)/60","metadata":{"_uuid":"84cbc6ba-6547-4699-a0fa-e0d57482d141","_cell_guid":"d1b7bd52-d482-4017-80f5-21bc668df04e","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:28.214314Z","iopub.execute_input":"2023-10-01T20:20:28.215222Z","iopub.status.idle":"2023-10-01T20:20:28.459681Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Looking at casual riders versus members, we can see that the average casual ride is about 27.7 minutes compared to the members' average ride of 12.3 minutes. The median rides are 12 minutes and 8 minutes respectively.","metadata":{"_uuid":"50fa8270-8741-4f95-9100-fc8f5fa9c950","_cell_guid":"3199b234-8511-43b5-b786-53cbbba6ed9f","trusted":true}},{"cell_type":"code","source":"aggregate(all_trips$ride_length/60 ~ all_trips$member_casual, FUN = mean)\naggregate(all_trips$ride_length/60 ~ all_trips$member_casual, FUN = median)","metadata":{"_uuid":"4a06ce02-aaf2-44f6-a665-997496d766ea","_cell_guid":"3d52d85e-e3df-44c1-aa25-af89f90e3d38","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:28.461506Z","iopub.execute_input":"2023-10-01T20:20:28.462394Z","iopub.status.idle":"2023-10-01T20:20:39.224405Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"aggregate(all_trips$day_of_week ~ all_trips$member_casual, FUN = mfv)","metadata":{"_uuid":"bec171ae-92fc-4e16-ae1d-c5b95321256d","_cell_guid":"4fd66470-d627-4ca9-99ab-e389fa6e32d0","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:39.227441Z","iopub.execute_input":"2023-10-01T20:20:39.229176Z","iopub.status.idle":"2023-10-01T20:20:42.786015Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Also, we can take a look at the average ride time by day for members and casual riders with duration again in minutes. Regardless of day of the week, casual users ride 2.7x to 3x longer than members, with both groups riding longer on weekends.","metadata":{"_uuid":"17451027-8607-4449-9725-eddb95f129fa","_cell_guid":"9555ba40-87bd-4703-91ff-5959de71d570","trusted":true}},{"cell_type":"code","source":"all_trips$day_of_week <- ordered(all_trips$day_of_week, levels=c(\"Sunday\", \"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\"))\naggregate(all_trips$ride_length/60 ~ all_trips$member_casual + all_trips$day_of_week, FUN = mean)","metadata":{"_uuid":"c78477a9-515f-4b4d-b876-05d9838f02a4","_cell_guid":"2ad4e459-d1c6-4394-8950-1568991ebd78","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:42.787777Z","iopub.execute_input":"2023-10-01T20:20:42.788695Z","iopub.status.idle":"2023-10-01T20:20:46.561466Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"all_trips %>%\n  mutate(weekday_num = lubridate::wday(started_at)) %>%\n  mutate(weekday_label = case_when(\n    weekday_num == 1 ~ \"Sun\",\n    weekday_num == 2 ~ \"Mon\",\n    weekday_num == 3 ~ \"Tue\",\n    weekday_num == 4 ~ \"Wed\",\n    weekday_num == 5 ~ \"Thu\",\n    weekday_num == 6 ~ \"Fri\",\n    weekday_num == 7 ~ \"Sat\",\n    TRUE ~ NA_character_\n  )) %>%\n  group_by(member_casual, weekday_label) %>%\n  summarise(number_of_rides = n(), average_duration = mean(ride_length/60)) %>%\n  arrange(member_casual, weekday_label)","metadata":{"_uuid":"60b627a6-c79e-4c02-9c12-a223f9af4681","_cell_guid":"e209d6a7-1716-44f5-8975-58d5ef8556a7","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:46.563678Z","iopub.execute_input":"2023-10-01T20:20:46.564638Z","iopub.status.idle":"2023-10-01T20:20:59.181433Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"##### Identify trends and relationships.\nHere are some key observations using the simple analyses above:\n\nCasual riders average longer rides than members. This makes sense as members are likely using the bike rental service for particular commutes (i.e. work or school) whereas casual riders are just that--casual (perhaps they are sightseeing)\n\n\nThe number of rides for both types of users starts off slow on Mondays, gradually increases to a peak on Saturdays with a small drop off on Sundays.","metadata":{"_uuid":"ddd84cee-e864-4477-abba-a4eb8c73996e","_cell_guid":"0b5331bb-6e79-4672-8c1b-b7be69ea01bb","trusted":true}},{"cell_type":"markdown","source":"#### Share","metadata":{"_uuid":"3c450f32-2021-4806-8484-dd4864331424","_cell_guid":"8069c29a-28e3-4ff1-b98e-67ed0ca43cfc","trusted":true}},{"cell_type":"code","source":"## ----Number of rides by rider type------------------------------------------\nall_trips %>%\n  mutate(weekday = factor(wday(started_at), \n                          levels = 1:7,\n                          labels = c(\"Sun\", \"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\"))) %>%\n  group_by(member_casual, weekday) %>%\n  summarise(number_of_rides = n(),\n            average_duration = mean(ride_length)) %>%\n  arrange(member_casual, weekday) %>%\n  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +\n  geom_col(position = \"dodge\") +\n  labs(title = \"Table 1: Number of Rides by Day and Rider Type\",\n       y = \"Number of Rides (1e+05 = 100,000)\",\n       x = \"Day of Week\")","metadata":{"_uuid":"b1c73215-027a-4ee1-a7e8-76b146df0f2d","_cell_guid":"8b2dc07b-e091-42a9-89e9-92aae393d80e","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:20:59.184413Z","iopub.execute_input":"2023-10-01T20:20:59.185998Z","iopub.status.idle":"2023-10-01T20:21:04.17184Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"Saturdays emerged as the day with the highest ride count for casual riders, whereas wednesday claimed the record for member riders’ most frequent day of riding.","metadata":{"_uuid":"c94989f7-f5d4-4a96-9265-b1ee383c1ac0","_cell_guid":"d4f4488a-b3a1-48a7-b81d-bedb51f69019","trusted":true}},{"cell_type":"code","source":"## ----Average duration-------------------------------------------------------\nall_trips %>% \n  mutate(weekday = factor(wday(started_at), \n                          levels = 1:7,\n                          labels = c(\"Sun\", \"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\"))) %>%\n  group_by(member_casual, weekday) %>% \n  summarise(number_of_rides = n()\n            ,average_duration = mean(ride_length/60)) %>% \n  arrange(member_casual, weekday)  %>% \n  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +\n  geom_col(position = \"dodge\") + \n  labs(title = \"Table 2: Average Ride Duration by Day and Rider Type\") + \n  ylab(\"Average Duration (minutes)\") + \n  xlab(\"Day of Week\")","metadata":{"_uuid":"3677a83e-e363-45f5-baec-4b6889b36de6","_cell_guid":"e15589d7-945d-45ee-b3d8-76a55807e676","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:21:04.173798Z","iopub.execute_input":"2023-10-01T20:21:04.174827Z","iopub.status.idle":"2023-10-01T20:21:07.874665Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"There was a notable difference of six hundred thousand in the count of rides between registered member riders and casual riders. Interestingly, despite this, casual riders surpassed member riders in terms of ride duration, spending over twice the amount of time on their rides. Furthermore, the weekly average for maximum ride length among casual riders significantly exceeded that of member riders.","metadata":{"_uuid":"ffdece1f-fcbd-431e-8faf-c63493c8cf43","_cell_guid":"5137beaa-4ab3-4b89-bb41-33ff28b91403","trusted":true}},{"cell_type":"code","source":"","metadata":{"_uuid":"52b85488-4f86-4810-b96f-a3cc5bf00261","_cell_guid":"1494eda4-14da-42c5-9250-742f76e5f020","collapsed":false,"jupyter":{"outputs_hidden":false},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"## ----Number of rides by day and bike type-----------------------------------\nall_trips %>% \n  mutate(weekday = factor(wday(started_at), \n                          levels = 1:7,\n                          labels = c(\"Sun\", \"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\"))) %>% \n  group_by(rideable_type, weekday) %>% \n  summarise(number_of_rides = n()\n            ,average_duration = mean(ride_length)) %>% \n  arrange(rideable_type, weekday)  %>% \n  ggplot(aes(x = weekday, y = number_of_rides, fill = rideable_type)) +\n  geom_col(position = \"dodge\") + \n  labs(title = \"Table 4: Number of Rides by Day and Bike Type\") + \n  ylab(\"Number of Rides (1e+05 = 100,000)\") + \n  xlab(\"Day of Week\")","metadata":{"_uuid":"15185882-12f8-49ef-b2a7-26115406a000","_cell_guid":"7f5a5fa5-2ec1-4161-9751-aab928653754","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:21:07.876669Z","iopub.execute_input":"2023-10-01T20:21:07.877727Z","iopub.status.idle":"2023-10-01T20:21:12.506572Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"The electric bike type has a considerably higher number of rides when compared to both the classic bike and the docked bike, which has a significantly lower ride count. \n\nThroughout the recorded duration, the classic bike stood out as the most prevalent type of rideable. Interestingly, both member riders and casual riders favored the classic bike for their rides. Notably, member riders opted not to utilize the docked bike at any point during this period.","metadata":{"_uuid":"1d648aa6-5de3-4e94-9651-d401b74c8715","_cell_guid":"eaf0914b-4d6a-40d2-9bfd-3ce736819d4a","trusted":true}},{"cell_type":"code","source":"","metadata":{"_uuid":"ee74c67d-e115-4d2d-a6af-ad06ea0e13af","_cell_guid":"ae8cb502-cd9c-474e-b015-672326ce5842","collapsed":false,"jupyter":{"outputs_hidden":false},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"## ----Number of rides by month and rider type--------------------------------\nall_trips %>% \n  group_by(member_casual, month) %>% \n  summarise(number_of_rides = n()\n            ,average_duration = mean(ride_length)) %>% \n  arrange(member_casual, month)  %>% \n  ggplot(aes(x = month, y = number_of_rides, group = member_casual)) +\n  geom_line(aes(color = member_casual)) + \n  geom_point() +\n  labs(title = \"Table 6: Number of Rides by Month and Rider Type\") + \n  ylab(\"Number of Rides (1e+05 = 100,000)\") + \n  xlab(\"Month\")","metadata":{"_uuid":"84cc03d4-921c-4eaf-bc28-fbd484a1959b","_cell_guid":"30b4f107-bb99-4241-a33d-30d6a7213a04","collapsed":false,"jupyter":{"outputs_hidden":false},"execution":{"iopub.status.busy":"2023-10-01T20:21:12.509513Z","iopub.execute_input":"2023-10-01T20:21:12.511347Z","iopub.status.idle":"2023-10-01T20:21:12.954924Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"In terms of peak riding activity, casual riders reached their highest point in July, whereas member riders observed their peak during August. Conversely, both categories of riders experienced their lowest activity of the year in January.","metadata":{"_uuid":"177d1f94-d064-4f43-8cbc-9f490e1482a1","_cell_guid":"e5456151-aee8-4254-99bb-3bd6b76dc29f","trusted":true}},{"cell_type":"markdown","source":"### Here is a summary of the key observations from above:\n\nCasual riders have notably longer average ride durations compared to members.\n\nSaturdays are the preferred riding day for casual riders, while Wednesdays are popular among members.\n\nCasual riders tend to ride more on weekends, whereas members have consistent riding patterns throughout the week.\n\nOn any given day, casual riders' rides are significantly longer than those of members.\n\nDespite 600,000 more rides by casual riders, they spend more than twice the time on their rides compared to members.\n\nElectric bikes are the most popular, followed by classic bikes, while docked bikes have fewer rides.\n\nClassic bikes are favored by both member and casual riders, with no member rides on docked bikes.\n\nPeak riding activity occurs in July for casual riders and in August for members, with low activity in January.","metadata":{"_uuid":"dda694d3-8dbf-48e3-a505-3d786a86854a","_cell_guid":"8bcc14da-848e-4205-a00e-a26ae660cdf6","trusted":true}},{"cell_type":"markdown","source":"### Act\n#### top three recommendations based on your analysis\nWeekend-Only Membership: Consider introducing a weekend-only membership option at a different price point than the full annual membership. This targeted membership would allow casual users to unlock bikes exclusively on Fridays, Saturdays, and Sundays. This strategy aligns with casual riders' weekend-oriented riding patterns, potentially enticing them to transition to a full annual membership for more flexibility during the week.\n\n\"See Our City\" Campaign: Launch a \"See Our City\" campaign specifically aimed at casual users. This campaign could include 52 suggested bike routes covering all major sights in the city, with one route for each weekend of the year. By renting bikes for these curated routes, casual riders could explore the city's attractions over the course of a year while also enjoying cost savings compared to individual rentals. This campaign could encourage frequent weekend riders to commit to a full annual membership.\n\nSummer Marketing Emphasis: Ensure that marketing campaigns are timed to coincide with the peak riding activity, which is in the summer. Consider launching promotional offers, discounts, or special events during the summer months to attract both casual riders and members. Highlight the benefits of riding during this season, such as pleasant weather and longer daylight hours, to encourage increased ridership and membership conversions.\n\nThese recommendations leverage the observed differences in riding behavior between casual users and members to tailor marketing strategies that could enhance user engagement, loyalty, and membership conversion.","metadata":{"_uuid":"07d7de5b-568e-4eb3-8c4f-8ddabf6da5cb","_cell_guid":"25d225b2-7fc6-4230-8708-37a7045cf3f3","trusted":true}}]}