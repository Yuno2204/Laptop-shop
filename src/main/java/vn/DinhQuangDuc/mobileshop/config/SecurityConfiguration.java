package vn.DinhQuangDuc.mobileshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import jakarta.servlet.DispatcherType;
import vn.DinhQuangDuc.mobileshop.service.CustomUserDetailsService;
import vn.DinhQuangDuc.mobileshop.service.UserService;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
        @Bean
        public PasswordEncoder passwordEncoder() {
                return new BCryptPasswordEncoder();
        }

        @Bean
        public UserDetailsService userDetailsService(UserService userService) {
                return new CustomUserDetailsService(userService);
        }

        @Bean
        public DaoAuthenticationProvider authProvider(
                        PasswordEncoder passwordEncoder,
                        UserDetailsService userDetailsService) {
                DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
                authProvider.setUserDetailsService(userDetailsService);
                authProvider.setPasswordEncoder(passwordEncoder);
                authProvider.setHideUserNotFoundExceptions(false);
                return authProvider;
        }

        @Bean
        public AuthenticationSuccessHandler customSuccessHandler() {
                return new CustomSuccessHandler();
        }

        @Bean
        public HttpSessionEventPublisher httpSessionEventPublisher() {
                return new HttpSessionEventPublisher();
        }

        @Bean
        SecurityFilterChain filterChain(HttpSecurity http, UserDetailsService userDetailsService) throws Exception {
                http
                                .authorizeHttpRequests(authorize -> authorize
                                                .dispatcherTypeMatchers(DispatcherType.FORWARD,
                                                                DispatcherType.INCLUDE)
                                                .permitAll()
                                                .requestMatchers("/", "/login", "/register", "/product/**",
                                                                "/products/**", "/about/**",
                                                                "/client/**", "/account/**", "/policy/**", "/css/**",
                                                                "/js/**",
                                                                "/images/**")
                                                .permitAll()
                                                .requestMatchers("/admin/**").hasRole("ADMIN")
                                                .anyRequest().authenticated())
                                .formLogin(formLogin -> formLogin
                                                .loginPage("/login")
                                                .failureUrl("/login?error")
                                                .successHandler(customSuccessHandler())
                                                .permitAll())
                                .sessionManagement((sessionManagement) -> sessionManagement
                                                // 2. SỬA "ALWAYS" THÀNH "IF_REQUIRED" TẠI ĐÂY
                                                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                                                .invalidSessionUrl("/logout?expired")
                                                .maximumSessions(1)
                                                .maxSessionsPreventsLogin(false))
                                .logout(logout -> logout
                                                .deleteCookies("JSESSIONID")
                                                .invalidateHttpSession(true)
                                                .logoutSuccessUrl("/?logout=success")) // Thêm chữ =success vào đây
                                .rememberMe(remember -> remember
                                                .key("mobile-shop-remember-me-key-123456")
                                                .rememberMeParameter("remember-me")
                                                .tokenValiditySeconds(24 * 60 * 60)
                                                .userDetailsService(userDetailsService))
                                .exceptionHandling(ex -> ex.accessDeniedPage("/access-deny"));
                return http.build();
        }

}
