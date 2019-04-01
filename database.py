import sqlite3
import json
from collections import OrderedDict
original_data = json.load(open('datadump.json'))
model = OrderedDict()

print("Open sqlite3 by typing the following command 'sqlite3 main.db'")
print("To display column names, type .headers ON and .mode column in sqllite3")
print("To expand column width type .width col1Size col2Size ....")
database = sqlite3.connect('main.db')

c = database.cursor()
for i in range(len(original_data)):
    model_name = original_data[i]["model"]
    field=[]
    for i in original_data[i]["fields"]:
        field.append(i)
    if model_name not in model and model_name in ["devops.question","devops.coursemodule","devops.quiz","auth.user","sessions.session","devops.grade","admin.logentry"]:
        model[model_name]=field
        key=model_name.replace(".","")
        if model_name == "devops.question":
            field = ["module","text","difficulty", "qtype","correct","answerA","answerB","answerC","answerD","answerE"]
            sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
            c.execute(sql)
        elif model_name == "devops.quiz":
            field=["module","minpass","numq","show_answers"]
            sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
            c.execute(sql)
        elif model_name == "devops.coursemodule":
            field=["module","title","next_module"]
            sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
            c.execute(sql)
        # elif model_name == "auth.user":
        #     field=["module","title","next_module"]
        #     sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
        #     c.execute(sql)
        # elif model_name == "sessions.session":
        #     field=["module","title","next_module"]
        #     sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
        #     c.execute(sql)
        # elif model_name == "devops.grade":
        #     field=["module","title","next_module"]
        #     sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
        #     c.execute(sql)
        # elif model_name == "admin.logentry":
        #     field=["module","title","next_module"]
        #     sql = "CREATE TABLE IF NOT EXISTS "+key+"(%s)" % ", ".join(field)
        #     c.execute(sql)

for i in range(len(original_data)):
    model_name = original_data[i]["model"]
    field=[]
    cur = database.cursor() 
    if model_name in ["devops.question"]:
        val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["text"],  original_data[i]["fields"]["difficulty"],original_data[i]["fields"]["qtype"], 
        original_data[i]["fields"]["correct"],original_data[i]["fields"]["answerA"], original_data[i]["fields"]["answerB"], original_data[i]["fields"]["answerC"],
        original_data[i]["fields"]["answerD"],str(original_data[i]["fields"]["answerE"]))
        cur.execute("INSERT INTO devopsquestion ( module, text,difficulty,qtype,correct,answerA,answerB,answerC,answerD,answerE) VALUES (?,?,?,?,?,?,?,?,?,?)",val)
    if model_name in ["devops.coursemodule"]:
        val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["title"],  original_data[i]["fields"]["next_module"])
        cur.execute("INSERT INTO devopscoursemodule ( module, title,next_module) VALUES (?,?,?)",val)
    if model_name in ["devops.quiz"]:
        val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["minpass"],  original_data[i]["fields"]["numq"],str(original_data[i]["fields"]["show_answers"]))
        cur.execute("INSERT INTO devopsquiz (module,minpass,numq,show_answers) VALUES (?,?,?,?)",val)
    # if model_name == "auth.user":
    #     val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["minpass"],  original_data[i]["fields"]["numq"],str(original_data[i]["fields"]["show_answers"]))
    #     cur.execute("INSERT INTO devopsquiz (module,minpass,numq,show_answers) VALUES (?,?,?,?)",val)
    # if model_name == "sessions.session":
    #     val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["minpass"],  original_data[i]["fields"]["numq"],str(original_data[i]["fields"]["show_answers"]))
    #     cur.execute("INSERT INTO devopsquiz (module,minpass,numq,show_answers) VALUES (?,?,?,?)",val)
    # if model_name == "devops.grade":
    #     val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["minpass"],  original_data[i]["fields"]["numq"],str(original_data[i]["fields"]["show_answers"]))
    #     cur.execute("INSERT INTO devopsquiz (module,minpass,numq,show_answers) VALUES (?,?,?,?)",val)
    # if model_name == "admin.logentry":
    #     val =(original_data[i]["fields"]["module"], original_data[i]["fields"]["minpass"],  original_data[i]["fields"]["numq"],str(original_data[i]["fields"]["show_answers"]))
    #     cur.execute("INSERT INTO devopsquiz (module,minpass,numq,show_answers) VALUES (?,?,?,?)",val)
database.commit()
database.close()

