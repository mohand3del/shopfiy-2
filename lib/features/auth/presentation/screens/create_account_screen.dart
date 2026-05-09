import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_cubit/core/routes/app_routes_constant.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_state.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/build_phone_field.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  Country? selectedCountry;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: context.read<AuthCubit>(),
        listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } 
            else if (state is AuthSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Account created successfully!")),
              );
            context.pushReplacement(AppRoutesConstant.loginScreen);
            } 
         
          
        },
        builder: (context, state) {
          
            final isLoading = state is AuthLoading;

          return Stack(
          children: [
          
            
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/bubble.png',
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Create\nAccount',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff202020),
                        height: 1.1,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 110,
                          height: 110,
                          child: DottedBorder(
                            borderType: BorderType.Circle,
                            dashPattern: const [14, 5],
                            color: const Color(0xFF0052FF),
                            strokeWidth: 2,
                            child: Container(
                              width: 110,
                              height: 110,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 36,
                                color: Color(0xFF0052FF),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.camera_alt_outlined,
                          size: 36,
                          color: Color(0xFF0052FF),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                     CustomTextField(hint: 'First Name', controller: _firstNameController, keyboardType: TextInputType.emailAddress,),
                    const SizedBox(height: 16),
                     
                      CustomTextField(hint: 'Last Name', controller: _lastNameController, keyboardType: TextInputType.emailAddress,),
                    const SizedBox(height: 16),
        
        
                    CustomTextField(hint: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress,),
                    const SizedBox(height: 16),
                    // Password Field
                    CustomTextField(hint: 'Password', controller: _passwordController, keyboardType: TextInputType.visiblePassword,isPassword: true,),
                    const SizedBox(height: 16),
                    // Phone Number Field
                    // buildPhoneField(
                    //   phoneController: _phoneController,
                    //   context: context,
                    //   selectedCountry: selectedCountry,
                    //   onCountrySelected: (country) {
                    //     setState(() {
                    //       selectedCountry = country;
                    //       _phoneController.text = '+${country.phoneCode} ';
        
                    //       _phoneController.selection = TextSelection.fromPosition(
                    //         TextPosition(offset: _phoneController.text.length),
                    //       );
                    //     });
                    //   },
                    // ),
                    const SizedBox(height: 60),
                    // Done Button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Done',
                        onPressed: () {
                          context.read<AuthCubit>().signUp(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Cancel Button
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            if(isLoading)...[
             Container(color: Colors.black26,
            
            child:  Center(child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF0052FF),
            )) ,
            ),
            ]
            
          ],
        );
          
        },
        
      ),
    );
  }
}
