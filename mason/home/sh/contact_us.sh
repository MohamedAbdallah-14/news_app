sh ./home/sh/contact_us_format.sh

mason make parameter -o ../ -c ./home/data/model/parameter/name.json 
mason make parameter -o ../ -c ./home/data/model/parameter/email.json 
mason make parameter -o ../ -c ./home/data/model/parameter/mobile.json 
mason make parameter -o ../ -c ./home/data/model/parameter/message_title.json 
mason make parameter -o ../ -c ./home/data/model/parameter/message_description.json 
mason make enum -o ../ -c ./home/data/model/enum/message_type.json 
mason make enum -o ../ -c ./home/data/model/enum/contact_us_steps.json 
mason make request_model -o ../ -c ./home/data/model/request_model/contact_us.json
mason make response_model -o ../ -c ./home/data/model/response_model/contact_us.json 
mason make request -o ../ -c ./home/data/request/contact_us.json
mason make repository -o ../ -c ./home/data/repository/contact_us.json --on-conflict append
mason make cubit -o ../ -c ./home/logic/contact_us.json
mason make screen -o ../ -c ./home/view/contact_us.json
