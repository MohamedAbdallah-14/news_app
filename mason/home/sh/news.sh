sh ./home/sh/news_format.sh
mason make feature -o ../ -c ./home/home.json 
mason make request_model -o ../ -c ./home/data/model/request_model/news.json
mason make response_model -o ../ -c ./home/data/model/response_model/news.json 
mason make response_model -o ../ -c ./home/data/model/response_model/news_model.json 
mason make request -o ../ -c ./home/data/request/news.json
mason make repository -o ../ -c ./home/data/repository/news.json --on-conflict append
mason make cubit -o ../ -c ./home/logic/news.json
mason make list_screen -o ../ -c ./home/view/news.json
