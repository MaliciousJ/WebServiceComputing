package koreatech.cse.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;

import java.util.Date;

@Aspect
public class AopTester {
    @Before("execution(* koreatech.cse.service.UserService.signup(..))")
    public void beforeMethod(JoinPoint joinPoint) {
        System.out.println("Before " + joinPoint.getSignature().getName() + ": " + new Date());
    }

    @After("execution(* koreatech.cse.service.UserService.signup(..))")
    public void afterMethod(JoinPoint joinPoint) {
        System.out.println("After " + joinPoint.getSignature().getName() + ": " + new Date());
    }

    @AfterReturning(pointcut = "execution(* koreatech.cse.service.UserService.signup(..))",
            returning= "result")
    public void afterReturningMethod(JoinPoint joinPoint, Object result) {
        System.out.println("After Returning " + joinPoint.getSignature().getName()
                + ": " + new Date() + ", Value = " + result);
    }

    @Around("execution(* koreatech.cse.service.UserService.signup(..))")
    public void aroundMethod(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("@Around is running!");
        System.out.println("Before " + joinPoint.getSignature().getName());
        joinPoint.proceed();
        System.out.println("After " + joinPoint.getSignature().getName());
    }

}
