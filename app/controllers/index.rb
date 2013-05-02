get '/' do
  # render home page
  @users = User.order("created_at DESC")
  @proficiencies = Proficiency.all
  @skills = Skill.all

  erb :index
end

get '/skills' do

  erb :skills
end

post '/skills' do
  p params[:skill]
  @skill = Skill.create(params[:skill])
  erb :proficiency
end

post '/proficiency' do
  @skill = Skill.find(params[:proficiency][:skill_id])
  @proficiency = Proficiency.new(params[:proficiency])
  if @proficiency.save 
    redirect '/'
  else
    @errors = "Required. Please enter Year and True/False"
    erb :proficiency
  end
end

get '/edit' do
  @skills = current_user.skills
  erb :edit
end

get '/edit/:id' do
  @skill = Skill.find(params[:id])
  erb :edit_skill
end

post '/edit' do
  p params[:skill_id]
  p params[:skill]
  p params[:proficiency]

  skill = Skill.find(params[:skill_id][:skill_id])
  p skill
  skill.update_attributes(params[:skill])
  p skill
  p skill.proficiencies.first
  skill.proficiencies.first.update_attributes(params[:proficiency])
  p skill.proficiencies.first

end



#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end
