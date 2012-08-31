Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "405056239556059", "c10b80f7c63f39da133e59fcc4fd0062"
  provider :google_oauth2, "58229183123.apps.googleusercontent.com", "EzO1-CLurAT3BkN4JEa2fLGm", { access_type: "offline", approval_prompt: "" }
  provider :linkedin, "43a27028-eb9d-4ae3-8ea7-aaea9f2ac751", "6988b670-b4f7-4ff8-b473-fa2feb279a43"
end