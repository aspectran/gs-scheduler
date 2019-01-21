/*
 * Copyright (c) 2008-2019 The Aspectran Project
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
package sample;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.util.logging.Log;
import com.aspectran.core.util.logging.LogFactory;

import java.time.LocalDateTime;
import java.util.concurrent.atomic.AtomicInteger;

@Component
@Bean("scheduledTasks")
public class ScheduledTasks {

    private static final Log log = LogFactory.getLog(ScheduledTasks.class);

    private static final AtomicInteger counter = new AtomicInteger();

    public String reportCurrentTime(Translet translet) {
        translet.setAttribute("count", counter.incrementAndGet());
        String msg = "The time is now " + LocalDateTime.now();
        log.info(msg);
        return msg;
    }

    public void occurError() {
        throw new IllegalStateException("An error occurred running job");
    }

}