package vn.hoidanit.laptopshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

// @SpringBootApplication
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class LaptopshopApplication {

	public static void main(String[] args) {
		// container
		ApplicationContext cen = SpringApplication.run(LaptopshopApplication.class, args);
		for (String s : cen.getBeanDefinitionNames()) {
			System.out.println(s);
		}
	}

}
