/*
 * Copyright (c) 2008-2023 The Aspectran Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gs.scheduler;

import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.utils.annotation.CronTrigger;
import com.aspectran.utils.annotation.Job;
import com.aspectran.core.component.bean.annotation.Request;
import com.aspectran.utils.annotation.Schedule;
import com.aspectran.core.component.bean.annotation.Transform;
import com.aspectran.core.component.bean.annotation.Value;
import com.aspectran.core.context.rule.type.FormatType;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;

import java.time.LocalDateTime;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicInteger;

@Component
@Bean("annotatedScheduledTasks")
@Schedule(
        id = "annotatedSchedule-1",
        scheduler = "annotatedScheduler",
        cronTrigger = @CronTrigger(
                expression = "0/10 * * * * ?"
        ),
        jobs = {
                @Job(translet = "annotated/job1.job")
        }
)
public class AnnotatedScheduledTasks {

    private static final AtomicInteger counter = new AtomicInteger();

    @Value("%{classpath:quartz.properties}")
    public Properties quartzProperties;

    @Request("annotated/job1.job")
    @Transform(FormatType.TEXT)
    public String printCurrentTime() {
        counter.incrementAndGet();
        return "The time is now " + LocalDateTime.now();
    }

    @Bean("annotatedScheduler")
    public org.quartz.Scheduler getScheduler() throws SchedulerException {
        SchedulerFactory factory = new StdSchedulerFactory(quartzProperties);
        return factory.getScheduler();
    }

}
