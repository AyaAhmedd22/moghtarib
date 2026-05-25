# TODO (Moghtarib)

- [x] Fix assets configuration in pubspec.yaml (add flutter.assets for assets/images)

- [ ] Add named routes in lib/main.dart and replace direct navigation where needed
- [ ] Update SplashScreen to:
  - [ ] Load token from CacheHelper
  - [ ] If token exists, call UserRoles endpoint
  - [ ] Navigate to correct role Home screen
  - [ ] If no token, navigate to WelcomeScreen
- [ ] Make WelcomeScreen layout responsive (remove magic fixed heights where needed)
- [ ] Improve RegisterView:
  - [ ] Add validators for all fields
  - [ ] Validate confirmPassword matches password
  - [ ] Add navigation text/link: "Already have an account? Login"
  - [ ] Ensure on register success navigates correctly
- [ ] Implement Login flow (matching Register UI/colors):
  - [ ] Create LoginCubit + LoginStates
  - [ ] Create LoginView
  - [ ] Add navigation link: "Don’t have an account? Register"
- [ ] Implement role-based navigation after login:
  - [ ] Add UserRoles API call in AuthRepo
  - [ ] Navigate to AdminHome / StudentHome / SemsarHome / SanaieeHome
- [ ] Create Home screens:
  - [ ] Base home scaffold with AppBar logo + side drawer
  - [ ] AdminHome / StudentHome / SemsarHome / SanaieeHome placeholders
- [ ] Fix API integration:
  - [ ] Add missing EndPoints.userRoles endpoint
  - [ ] Ensure login/register works with ApiHelper and Cubits
  - [ ] Ensure token headers handled correctly
- [ ] Run flutter pub get + flutter analyze + flutter run

