--Begin Tools.lua :)

function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

 function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
local function index_function(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end
local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 
local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

 function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end
 function exi_filez()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.json$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exiz(name)
    for k,v in pairs(exi_filez()) do
        if name == v then
            return true
        end
    end
    return false
end



local function sudolist(msg)
text = "*♼￤ قائمه المطورين : *\n"
local i = 1
for v,user in pairs(_config.sudo_users) do
text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
i = i +1
end
return text
end


local function chat_list(msg)
i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
if not data[tostring(groups)] then
return 'لا يوجد مجموعات مفعلة حاليا .'
end
local message = '♼￤ قـائمـه الـكـروبـات :\n\n'
for k,v in pairsByKeys(data[tostring(groups)]) do
local group_id = v
if data[tostring(group_id)] then
settings = data[tostring(group_id)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
name = n:gsub("", "")
group_name_id = check_markdown(name).. ' \n\n`*` ايدي ☜ (`' ..group_id.. '`)\n'

group_info = i..' ـ '..group_name_id

i = i + 1
end
end
message = message..group_info
end
return message
end

local function chat_num(msg)
i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
if not data[tostring(groups)] then
return 'لا يوجد مجموعات مفعلة حاليا .'
end
local message = '♼￤ قـائمـه الـكـروبـات :\n\n'
for k,v in pairsByKeys(data[tostring(groups)]) do
local group_id = v
if data[tostring(group_id)] then
settings = data[tostring(group_id)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
name = n:gsub("", "")
i = i + 1
end
end
end
return '♼￤ عدد المجموعات المفعلة  : `'..i..'` ♲'
end






 function botrem(msg)
local data = load_data(_config.moderation.data)
data[tostring(msg.to.id)] = nil
save_data(_config.moderation.data, data)
local groups = 'groups'
if not data[tostring(groups)] then
data[tostring(groups)] = nil
save_data(_config.moderation.data, data)
end
data[tostring(groups)][tostring(msg.to.id)] = nil
save_data(_config.moderation.data, data)
tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end



local function action_by_reply(arg, data)
local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then

if cmd == "الرتبه" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = "لا يوجد معرف !"
end


if data.id_ == our_id  then
rank = 'هذا البوت 📮'
elseif is_sudo1(data.id_) then
rank = 'انه المطور'
elseif is_owner1(arg.chat_id,data.id_) then
rank = 'مدير المجموعه '
elseif is_mod1(arg.chat_id,data.id_) then
rank = ' ادمن في البوت '
elseif is_whitelist(data.id_, arg.chat_id)  then
rank = 'عضو مميز '
else
rank = 'مجرد عضو '
end
local rtba = '♼￤ اسمه ⇠ : '..check_markdown(data.first_name_)..'\n♼￤معرفه ⇠ : '..user_name..' \n♼￤ رتبته ⇠ : '..rank



return tdcli.sendMessage(arg.chat_id, 1, 0, rtba, 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end

if cmd == "رفع مطور" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ انه بالتأكيد مطور ☑️_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})

save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ تم ترقيته ليصبح مطور ☑️_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "تنزيل مطور" then
local function desudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
local nameid = index_function(tonumber(data.id_))

if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ انه بالتأكيد ليس مطور ☑️_', 0, "md")
end
table.remove(_config.sudo_users, nameid)

save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ تم تنزيله من المطورين ☑️_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
else
return tdcli.sendMessage(data.chat_id_, "", 0, "*◈￤ لا يوجد", 0, "md")
end
end

local function action_by_username(arg, data)
local cmd = arg.cmd
if not arg.username then return false end
if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "رفع مطور" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ انه بالتأكيد مطور ☑️_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ تم ترقيته ليصبح مطور ☑️_', 0, "md")
end
if cmd == "تنزيل مطور" then
if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ انه بالتأكيد ليس مطور ☑️_', 0, "md")
end
local nameid = index_function(tonumber(data.id_))

table.remove(_config.sudo_users, nameid)

--table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ تم تنزيله من المطورين ☑️_', 0, "md")
end
else
return tdcli.sendMessage(arg.chat_id, "", 0, "_♺￤  لا يوجد _", 0, "md")
end
end

local function action_by_id(arg, data)
local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end

if cmd == "رفع مطور" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ انه بالتأكيد مطور ☑️_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ تم ترقيته ليصبح مطور ☑️_', 0, "md")
end
if cmd == "تنزيل مطور" then
local nameid = index_function(tonumber(data.id_))

if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ انه بالتأكيد ليس مطور ☑️_', 0, "md")
end
table.remove(_config.sudo_users, nameid)
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '♼￤ _العضو ⇠_ : '..user_name..' \n♼￤ _الايدي ⇠_ : *'..data.id_..'*\n♼￤_ تم تنزيله من المطورين ☑️_', 0, "md")
end
else
return tdcli.sendMessage(arg.chat_id, "", 0, "_◈￤ لا يوجد _", 0, "md")
end
end


local function run(msg, matches)
if tonumber(msg.from.id) == SUDO then
if matches[1] == "تنظيف البوت" then
run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
run_bash("rm -rf ~/.telegram-cli/data/photo/*")
run_bash("rm -rf ~/.telegram-cli/data/animation/*")
run_bash("rm -rf ~/.telegram-cli/data/video/*")
run_bash("rm -rf ~/.telegram-cli/data/audio/*")
run_bash("rm -rf ~/.telegram-cli/data/voice/*")
run_bash("rm -rf ~/.telegram-cli/data/temp/*")
run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
run_bash("rm -rf ~/.telegram-cli/data/document/*")
run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
return "*♺￤تم حذف الذاكره المؤقته في التيجي*"
end
if matches[1] == "رفع مطور" then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="رفع مطور"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع مطور"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع مطور"})
end
end
if matches[1] == "تنزيل مطور" then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل مطور"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل مطور"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل مطور"})
end
end
end


if msg.to.type == 'channel' or msg.to.type == 'chat' then

if matches[1] == "الرتبه" and not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="الرتبه"})
end

local data = load_data(_config.moderation.data)
local groups = 'groups'
if data[tostring(groups)] then
settings = data[tostring(msg.to.id)]['settings'] 
end


if matches[1] == 'اذاعه عام' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "♼￤هذا الاوامر للمطور الاساسي فقط " 
end
end
local list = redis:smembers('users')
for i = 1, #list do
tdcli.sendMessage(list[i], 0, 0, matches[2], 0)			
end
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
local i =1 
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
i=i+1
end
tdcli.sendMessage(msg.to.id, 0, 0, '♼￤ تم اذاعه الى '..i..' مجموعات 📩', 0)			
tdcli.sendMessage(msg.to.id, 0, 0,'♼￤ تم اذاعه الى `'..redis:scard('users')..'` من المشتركين 👍🏿', 0)	
end

if matches[1] == 'اذاعه خاص' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "♼￤هذا الاوامر للمطور الاساسي فقط " 
end
end


local list = redis:smembers('users')
for i = 1, #list do
tdcli.sendMessage(list[i], 0, 0, matches[2], 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0,'♼￤ تم اذاعه الى `'..redis:scard('users')..'` من المشتركين 📩', 0)	
end

if matches[1] == 'اذاعه' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "♼￤هذا الاوامر للمطور الاساسي فقط  " 
end
end

local data = load_data(_config.moderation.data)		
local bc = matches[2]			
local i =1 
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
i=i+1
end
tdcli.sendMessage(msg.to.id, 0, 0, '♼￤ تم اذاعه الى '..i..' مجموعات 📩', 0)			

end

if matches[1] == 'المطورين' and is_sudo(msg) then
return sudolist(msg)
end

if matches[1] == 'المجموعات' and is_sudo(msg) then
return chat_num(msg)
end

if matches[1] == 'قائمه المجموعات' and is_sudo(msg) then
return chat_list(msg)
end

if matches[1] == 'تعطيل' and string.match(matches[2], '^-%d+$') and is_sudo(msg) then
local data = load_data(_config.moderation.data)
-- Group configuration removal
data[tostring(matches[2])] = nil
save_data(_config.moderation.data, data)
local groups = 'groups'
if not data[tostring(groups)] then
data[tostring(groups)] = nil
save_data(_config.moderation.data, data)
end
data[tostring(groups)][tostring(matches[2])] = nil
save_data(_config.moderation.data, data)
tdcli.sendMessage(matches[2], 0, 1, "تم تعطيل البوت من قبل المطور ", 1, 'html')
tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
return '_المجموعه_ *'..matches[2]..'* _تم تعطيلها_'
end
if matches[1] == '=' then
tdcli.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'html')
end
if matches[1] == 'المدراء' and is_sudo(msg) then
return adminlist(msg)
end
if matches[1] == 'رامبو غادر' and is_sudo(msg) then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك باي 😢💔 ️', 1, 'html')
tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
botrem(msg)

end   

if matches[1] == "كشف الادمن" and not matches[2] and is_owner(msg) then
local checkmod = false
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
local secchk = true
for k,v in pairs(b.members_) do
if v.user_id_ == tonumber(our_id) then
secchk = false
end
end
if secchk then
return tdcli.sendMessage(msg.to.id, msg.id, 1, '♼￤ كلا البوت ليس ادمن في المجموعة ♨️', 1, "md")
else
return tdcli.sendMessage(msg.to.id, msg.id, 1, '♼￤ نعم انه ادمن في المجموعة ', 1, "md")
end
end, nil)
end

if is_sudo(msg) and  matches[1] == "راسل" then
if matches[2] and string.match(matches[2], '@[%a%d]') then
local function rasll (extra, result, success)
if result.id_ then
if result.type_.user_.username_ then
user_name = '@'..check_markdown(result.type_.user_.username_)
else
user_name = check_markdown(result.first_name_)
end
tdcli.sendMessage(msg.chat_id_, 0, 1, '♼￤ تم ارسال الرسالة لـ '..user_name..' 📩️' , 1, 'md')
tdcli.sendMessage(result.id_, 0, 1, extra.msgx, 1, 'html')
end
end
return   tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, rasll, {msgx=matches[3]})
elseif matches[2] and string.match(matches[2], '^%d+$') then
tdcli.sendMessage(msg.to.id, 0, 1, '♼￤ تم ارسال الرسالة لـ ['..matches[2]..'] 📩️' , 1, 'html')
tdcli.sendMessage(matches[2], 0, 1, matches[3], 1, 'html')
end
end


if matches[1] == "مواليدي" then
local kyear = tonumber(os.date("%Y"))
local kmonth = tonumber(os.date("%m"))
local kday = tonumber(os.date("%d"))
--
local agee = kyear - matches[2]
local ageee = kmonth - matches[3]
local ageeee = kday - matches[4]

return  " 👮🏼 مرحبا عزيزي"
.."\n👮🏼 لقد قمت بحسب عمرك 👮🏻‍♀️  \n\n"

.."♳￤ "..agee.." سنه\n"
.."♴￤ "..ageee.." اشهر \n"
.."♵￤ "..ageeee.." يوم \n\n"

end
-------

if matches[1]== 'رسائلي' or matches[1]=='رسايلي' then
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)
return '📫￤ عدد رسائلك المرسله : `'..msgs..'` رساله \n\n'
end
if matches[1]:lower() == 'معلوماتي' or matches[1]:lower() == 'موقعي'  then
if msg.from.first_name then
if msg.from.username then username = '@'..check_markdown(msg.from.username)
else username = '<i>ما مسوي  😹💔</i>'
end
if is_sudo(msg) then rank = 'المطور '
elseif is_owner(msg) then rank = 'مدير المجموعه '
elseif is_sudo(msg) then rank = 'اداري في البوت '
elseif is_mod(msg) then rank = 'ادمن في البوت '
elseif is_whitelist(msg.from.id,msg.to.id)  then rank = 'عضو مميز '
else rank = 'مجرد عضو '
end
local text = '*👨🏽‍🔧¦ اهـلا بـك عزيزي :\n\n♳￤ الاسم الاول :* _'..msg.from.first_name
..'_\n*♴￤ الاسم الثاني :* _'..(msg.from.last_name or "---")
..'_\n*♵￤ المعرف :* '..username
..'\n*♶￤ الايدي :* ( `'..msg.from.id
..'` )\n*♷￤ ايدي الكروب :* ( `'..msg.to.id
..'` )\n*♸￤ موقعك :* _'..rank
..'_\n*♼￤ مـطـور البوت *: '..sudouser..'\n👨🏽‍🔧'
tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end
end




if matches[1] == "الاوامر" then
if not is_mod(msg) then return "♲￤ للاداريين فقط 🎖" end
local text = [[
♼￤ مرحبا بك عزيزي الاوامر::
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♳￤`م1` ⇜ اوامر الاداره  
♴￤`م2` ⇜ اوامر اعدادت الكروب
♵￤`م3` ⇜ اوامر الحماية 
♶￤`م4` ⇜ الاوامـر الـ؏ـامه 
♷￤`م5` ⇜ اوامر اضافه ردود
♸￤`م6` ⇜ اوامر الزخرفه    
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※

♼￤ٴ [اضغط هنا لمعلومات اكثر 🌾](t.me/MUSICSTAR_TV)

📭￤`الـمـطـور`  ⇜  ]]..sudouser

return tdcli.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')

end

if matches[1]== 'م1' then
if not is_mod(msg) then return "♲￤ للاداريين فقط 🎖" end
local text =[[
〽️￤[مرحبا بك في الاوامر الاولى:](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
👨‍￤اوامر التنزيل والرفع بـ البوت::
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤`رفع ادمن `⇜ لرفع ادمن 
♼￤`تنزيل ادمن` ⇜ لتنزيل ادمن
♼￤`رفع عضو مميز` ⇜ لرفع مميز 
♼￤`تنزيل عضو مميز`⇜لتنزيل مميز 
♼￤` الادمنيه` ⇜ لعرض الادمنيه
♼￤`المدراء` ⇜ لعرض المدراء                       
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
💎￤[لمعلومات اثر اضغط هنا🌾](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤`طرد بالرد `⇜ لطرد العضو 
♼￤`حظر بالرد` ⇜ لحظر وطرد 
♼￤`الغاء الحظر` ⇜ لالغاء الحظر 
♼￤`منع` ⇜ لمنع كلمه في الكروب
♼￤`الغاء منع` ⇜ لالغاء منع الكلمه  
♼￤`كتم` ⇜ لكتم عضو  
♼￤`الغاء الكتم`⇜ لالغاء الكتم
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
📫￤`الـمـطـور`  ⇜  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'م2' then
if not is_mod(msg) then return "♲￤ للاداريين فقط 🎖" end
local text = [[
〽️￤[مرحبا عزيزي اوامر اعدادت👇🏿](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲￤ [اوامر الوضع للمجموعه👇🏿](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤`ضع الترحيب`⇜لوضع ترحيب  
♼￤` ضع قوانين`⇜ لوضع قوانين 
♼￤` ضع وصف` ⇜ لوضع وصف    
♼￤` الرابط` ⇜ لعرض الرابط  
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲￤ [اوامر رؤيه الاعدادات 👇🏿](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤ `القوانين `⇜لعرض القوانين  
♼￤ `المكتومين` ⇜لعرض المكتومين 
♼￤ `المطور `⇜ لعرض المطور 
♼￤ `معلوماتي` ⇜لعرض معلوماتك  
♼￤ `الحمايه` ⇜ لعرض اعدادات 
♼￤`الوسائط `⇜لعرض  الميديا 
♼￤`المجموعه` ⇜معلومات المجموعه 
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
📫￤`الـمـطـور`  ⇜ ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'م3' then
if not is_mod(msg) then return "♲￤ للاداريين فقط 🎖" end
local text = [[
〽️￤[مرحبا عزيزي اوامر حمايه👇🏿](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲￤ اوامر حمايه المجموعه ⚡️
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤`قفل￤ فتح` ⇠ التثبيت
♼￤`قفل￤ فتح `⇠ التعديل
♼￤`قفل￤ فتح `⇠ البصمات
♼￤`قفل￤ فتح` ⇠ الـفيديو
♼￤`قفل￤ فتح `⇠ الـصوت 
♼￤️`قفل￤ فتح `⇠  الـصور 
♼￤`قفل￤ فتح `⇠ الملصقات
♼￤`قفل￤ فتح `⇠ المتحركه
♼￤`قفل￤ فتح `⇠ الدردشه
♼￤`قفل￤ فتح `⇠ الملصقات
♼￤`قفل￤ فتح `⇠ الروابط
♼￤`قفل￤ فتح `⇠التاك
♼￤`قفل￤ فتح `⇠ البوتات
♼￤`قفل￤ فتح `⇠ البوتات بالطرد
♼￤`قفل￤ فتح `⇠ الكلايش
♼￤`قفل￤ فتح `⇠ التكرار
♼￤`قفل￤ فتح `⇠ التوجيه
♼￤`قفل￤ فتح `⇠ الجهات 
♼￤`قفل￤ فتح `⇠ المجموعه 
♼￤`قفل￤ فتح `⇠ الـكـل
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲￤`تفعيل  ￤ تعطيل `⇠ الترحيب 
♲￤` تفعيل ￤ تعطيل `⇠ الردود 
♲️￤` تفعيل ￤ تعطيل `⇠التحذير
♲️￤` تفعيل ￤ تعطيل `⇠ الايدي 
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
📫￤`الـمـطـور`  ⇜  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'م4' then
if not is_mod(msg) then return "♲￤ للاداريين فقط 🎖" end
local text = [[
〽￤ [مرحبا عزيزي اوامر اضافيه👇🏿 ](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤ معلوماتك الشخصيه 📩
♼￤ `اسمي` ⇠ عرض اسمك 
♼￤ `رتبتي` ⇠ لعرض رتبتك 
♼￤ `الرتبه ` ⇠  لعرض الرتبه 
♼￤ `معرفي` ⇠ لعرض معرفك 
♼￤ `ايديي `⇠ لعرض ايديك 
♼￤`رقمي ` ⇠  لعرض رقمك  
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲️‍￤[`اوامر` التحشيش 👇🏿](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♼￤`تحب` + (اسم الشخص)
♼￤` بوس` + (اسم الشخص) 
♼￤` كول `+ (اسم الشخص) 
♼￤` كله `+ الرد + (الكلام) 
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
📫￤`الـمـطـور`  ⇜ ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "م المطور" then
if not is_sudo(msg) then return "♲￤ للمطوين فقط 🎖" end
local text = [[
  [اوامـر خاصه بل  الـمـطـورين 👨🏻‍🚀](t.me/MUSICSTAR_TV)
♺￤  ٴ※٠٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠٠※    
♲￤  تفعيل :لتفعيل البوت 👍🏽
♲￤ تعطيل :لتعطيل البوت 🖐🏽
♺￤  ٴ※٠٠٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠٠٠※    
♺￤ رفع مدير    ◄ { رد / معرف }
♺￤تنزيل مدير  ◄ { رد / معرف }
♺￤رفع اداري    ◄ { رد / معرف }
♺￤تنزيل اداري ◄ { رد / معرف }
♺￤رفع ادمن     ◄ { رد / معرف }
♺￤تنزيل ادمن  ◄ { رد / معرف }
♺￤رفع مطور    ◄ { رد / معرف } 
♺￤تنزيل مطور ◄ { رد / معرف }
♺￤ ٴ※٠٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠٠٠※    
♻￤ اذاعه  + الكلام ☑️
♻￤ ارسل  + معرف الشخص 
♻￤ رامبو غادر  ◄ لخروج البوت 
♻￤اذاعه خاص + الكلام 🖐🏽
♻￤اذاعه عام + الكلام 💡
♻￤تفعيل / تعطيل الاذاعه
♻￤المشتركين : لعرض مشتركين 
♺￤ٴ※٠٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠٠※    
♽￤المغادره تلقائيا ◄ تفعيل 🔺
♽￤المغادره تلقائيا ◄ تعطيل 🔻
♽￤ مسح + من1الى 100 للتنضيف 📭
♽￤المجموعات : لعرض الكروبات
♽￤ قائمة المجموعات : لعرض كروبات
♽￤اوامر الملفات : للمطور الاساسي
♽￤ تنظيف البوت  : لتنظيف البوت 
♺￤ ٴ※٠٠٠٠٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠٠٠※
📫￤المـٰ۪ہٰطـٰ۪ہٰ๋͜ور ⇜]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'م5' then
if not is_owner(msg) then return "♲￤ للمدراء فقط 🎖" end

local text = [[
♽￤[مرحبا عزيزي اوامر الردود 👇🏿](t.me/MUSICSTAR_TV)
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲￤🔺اوامـر المدير فقط 🔻
♼￤ `الردود` ⇠  لعرض الردود المثبته
♼￤ `اضف رد` ⇠  أضافةرد جديد
♼￤ `مسح رد`   ⇠ المراد مسحه
♼￤ `مسح الردود` ⇠ لمسح الكل
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
♲￤🔺اوامـر المطور فقط 🔻
♺￤ `الردود العامه` ⇠  لعرض الردود 
♺￤ `اضف رد للكل `⇠  أضافةرد جديد
♺￤ `مسح رد عام `⇠ المراد مسحه
♺￤ `مسح الردود العامه` ⇠ لمسح الكل
♼￤ٴ※٠٠٠٠٠٠٠※❂※٠٠٠٠٠٠٠※
📫￤`الـمـطـور`  ⇜  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "م6" then
if not is_mod(msg) then return "♲￤ للاداريين فقط 🎖" end
local text = [[♲️￤ اوامر الزخرفةة 
♲￤ زخرف + الكلمه المراد زخرفتها بالانكلش ♼
♲￤ زخرفه + الكلمه المراد زخرفتها بالعربي ♼
📫￤`الـمـطـور`  ⇜  ]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "اوامر الملفات" then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط ♲￤" end
local text = [[♲￤🔻 اوامر الملفات 🔻
♼￤ ٴ /p  لعرض قائمه الملفات  
♼￤ٴ /p + اسم الملف المراد تفعيله 
♼￤ٴ /p - اسم الملف المراد تعطيله 
♼￤ٴ sp + الاسم | لارسال الملف اليك 
♼￤ٴ dp + اسم الملف المراد حذفه 
♼￤ٴ sp all | لارسالك كل ملفات 
♼￤ٴتحديث السورس ⇜ يحدث↯ 
♼￤ٴ[السورس الى الاصدار الجديد] 
♼￤ٴنسخه احتياطيه ⇜ لجلب ↯ 
♼￤ٴنسخه الكروبات لحفظ امن البوت] 
♼￤ٴرفع نسخه احتياطيه ⇜ لرفع↯ 
♼￤ٴ[ النسخه الاحتياطيه ]
♼￤ٴ save + اسم الملف ⇜ لرفع↯ 
♼￤[ الملفات من التلي الى سيرفر ]
📫￤`الـمـطـور`  ⇜  ]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end



if matches[1] == "المطور" then
local text = [[
♲￤- اهـلا بـك عـزيـزي 🦁
♲￤- [لاخر الاخبار اضغط 🌾](t.me/MUSICSTAR_TV)

♲￤- `للتواصل 🌾`  ⇜  ]]..sudouser

return tdcli.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')

end

end


end

return { 
patterns = {   
"^(كشف الادمن)$", 
"^(م المطور)$", 
"^(م5)$", 
"^(م6)$", 
"^(اوامر الملفات)$", 
"^(الاوامر)$", 
"^(م1)$", 
"^(م2)$", 
"^(م3)$", 
"^(م4)$", 
"^(المطور)$", 
"^(الرتبه)$", 
"^(رفع مطور)$", 
"^(تنزيل مطور)$",
"^(المطورين)$",
"^(رفع مطور) (.*)$",
"^(تنزيل مطور) (.*)$",
"^(=)$",
"^(قائمه المجموعات)$",
"^(المجموعات)$",
"^(رسائلي)$",
"^(رسايلي)$",
"^(معلوماتي)$",
"^(موقعي)$",
"^(تنظيف البوت)$",
"^(تفعيل) (.*)$",
"^(تعطيل) (.*)$",
"^(اذاعه عام) (.*)$",
"^(اذاعه خاص) (.*)$",
"^(اذاعه) (.*)$",
"^(اضافه) (@[%a%d%_]+)$",
"^(راسل) (@[%a%d%_]+) (.*)$",
"^(راسل) (%d+) (.*)$",
"^(زعيم غادر)$",
"^(مواليدي) (.+)/(.+)/(.+)",
"^!!tgservice (.+)$",

}, 
run = run,
}
