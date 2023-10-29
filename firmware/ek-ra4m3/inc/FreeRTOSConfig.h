/* generated configuration header file - do not edit */
//#ifndef FREERTOSCONFIG_H_
//#define FREERTOSCONFIG_H_
/*-----------------------------------------------------------
 * Application specific definitions.
 *
 * These definitions should be adjusted for your particular hardware and
 * application requirements.
 *
 * THESE PARAMETERS ARE DESCRIBED WITHIN THE 'CONFIGURATION' SECTION OF THE
 * FreeRTOS API DOCUMENTATION AVAILABLE ON THE FreeRTOS.org WEB SITE.
 *
 * See http://www.freertos.org/a00110.html
 *----------------------------------------------------------*/

#include "FreeRTOS.h"
#include "bsp_api.h"

/* Constants related to the behaviour or the scheduler. */
#define configCPU_CLOCK_HZ 100000000
#define configTICK_RATE_HZ 1000
#define configUSE_PORT_OPTIMISED_TASK_SELECTION                                \
    0 // There is no port for this...
#define configUSE_PREEMPTION 1
#define configUSE_TIME_SLICING 1
#define configMAX_PRIORITIES (5)
#define configIDLE_SHOULD_YIELD 1
#define configUSE_16_BIT_TICKS 0 /* Only for 8 and 16-bit hardware. */

/* Constants that describe the hardware and memory usage. */
#define configMINIMAL_STACK_SIZE ((unsigned short)200)
#define configMAX_TASK_NAME_LEN (12)

/* Note heap_5.c is used so this only defines the part of the heap that is in
the first block of RAM on the LPC device.  See the initialisation of the heap
in main.c. */
#define configTOTAL_HEAP_SIZE ((size_t)(10 * 1024))

/* Constants that build features in or out. */
#define configUSE_MUTEXES 1
#define configUSE_TICKLESS_IDLE 1
#define configUSE_APPLICATION_TASK_TAG 0
#define configUSE_NEWLIB_REENTRANT 0
#define configUSE_CO_ROUTINES 0
#define configUSE_COUNTING_SEMAPHORES 1
#define configUSE_RECURSIVE_MUTEXES 1
#define configUSE_QUEUE_SETS 0
#define configUSE_TASK_NOTIFICATIONS 1

/* Constants that define which hook (callback) functions should be used. */
#define configUSE_IDLE_HOOK 0
#define configUSE_TICK_HOOK 0
#define configUSE_MALLOC_FAILED_HOOK 0

/* Constants provided for debugging and optimisation assistance. */
#define configCHECK_FOR_STACK_OVERFLOW 2
#define configASSERT(x)                                                        \
    if ((x) == 0) {                                                            \
        taskDISABLE_INTERRUPTS();                                              \
        for (;;)                                                               \
            ;                                                                  \
    }
#define configQUEUE_REGISTRY_SIZE 0

/* Software timer definitions. */
#define configUSE_TIMERS 1
#define configTIMER_TASK_PRIORITY (3)
#define configTIMER_QUEUE_LENGTH 5
#define configTIMER_TASK_STACK_DEPTH (configMINIMAL_STACK_SIZE)

/* Set the following definitions to 1 to include the API function, or zero
to exclude the API function.  NOTE:  Setting an INCLUDE_ parameter to 0 is only
necessary if the linker does not automatically remove functions that are not
referenced anyway. */
#define INCLUDE_vTaskPrioritySet 1
#define INCLUDE_uxTaskPriorityGet 1
#define INCLUDE_vTaskDelete 1
#define INCLUDE_vTaskCleanUpResources 0
#define INCLUDE_vTaskSuspend 1
#define INCLUDE_vTaskDelayUntil 1
#define INCLUDE_vTaskDelay 1
#define INCLUDE_uxTaskGetStackHighWaterMark 0
#define INCLUDE_xTaskGetIdleTaskHandle 0
#define INCLUDE_eTaskGetState 1
#define INCLUDE_xTaskResumeFromISR 0
#define INCLUDE_xTaskGetCurrentTaskHandle 1
#define INCLUDE_xTaskGetSchedulerState 0
#define INCLUDE_xSemaphoreGetMutexHolder 0
#define INCLUDE_xTimerPendFunctionCall 1

/* This demo makes use of one or more example stats formatting functions.  These
format the raw data provided by the uxTaskGetSystemState() function in to human
readable ASCII form.  See the notes in the implementation of vTaskList() within
FreeRTOS/Source/tasks.c for limitations. */
#define configUSE_STATS_FORMATTING_FUNCTIONS 1
// CLI commands. */
#define configUSE_TRACE_FACILITY 1

/* Dimensions a buffer that can be used by the FreeRTOS+CLI command
interpreter.  See the FreeRTOS+CLI documentation for more information:
http://www.FreeRTOS.org/FreeRTOS-Plus/FreeRTOS_Plus_CLI/ */
#define configCOMMAND_INT_MAX_OUTPUT_SIZE 2048

#define configSUPPORT_DYNAMIC_ALLOCATION (1)

/* Device specific defines*/
#define configLIBRARY_LOWEST_INTERRUPT_PRIORITY ((1 << __NVIC_PRIO_BITS) - 1)
#define configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY ((1))
#define configMAX_SYSCALL_INTERRUPT_PRIORITY                                   \
    (configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY << (8 - __NVIC_PRIO_BITS))
#define configMAX_API_CALL_INTERRUPT_PRIORITY                                  \
    (configMAX_SYSCALL_INTERRUPT_PRIORITY)
#define configENABLE_FPU (1)
#define configENABLE_MPU (0)
#define configENABLE_TRUSTZONE (0)

/*-----------------------------------------------------------------*/

/*

#ifndef configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS
#define configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS (0)
#endif
#ifndef INCLUDE_vTaskPrioritySet
#define INCLUDE_vTaskPrioritySet (1)
#endif
#ifndef INCLUDE_uxTaskPriorityGet
#define INCLUDE_uxTaskPriorityGet (1)
#endif
#ifndef INCLUDE_vTaskDelete
#define INCLUDE_vTaskDelete (1)
#endif
#ifndef INCLUDE_vTaskSuspend
#define INCLUDE_vTaskSuspend (1)
#endif
#ifndef INCLUDE_xResumeFromISR
#define INCLUDE_xResumeFromISR (1)
#endif
#ifndef INCLUDE_vTaskDelayUntil
#define INCLUDE_vTaskDelayUntil (1)
#endif
#ifndef INCLUDE_vTaskDelay
#define INCLUDE_vTaskDelay (1)
#endif
#ifndef INCLUDE_xTaskGetSchedulerState
#define INCLUDE_xTaskGetSchedulerState (1)
#endif
#ifndef INCLUDE_xTaskGetCurrentTaskHandle
#define INCLUDE_xTaskGetCurrentTaskHandle (1)
#endif
#ifndef INCLUDE_uxTaskGetStackHighWaterMark
#define INCLUDE_uxTaskGetStackHighWaterMark (0)
#endif
#ifndef INCLUDE_xTaskGetIdleTaskHandle
#define INCLUDE_xTaskGetIdleTaskHandle (0)
#endif
#ifndef INCLUDE_eTaskGetState
#define INCLUDE_eTaskGetState (0)
#endif
#ifndef INCLUDE_xEventGroupSetBitFromISR
#define INCLUDE_xEventGroupSetBitFromISR (1)
#endif
#ifndef INCLUDE_xTimerPendFunctionCall
#define INCLUDE_xTimerPendFunctionCall (0)
#endif
#ifndef INCLUDE_xTaskAbortDelay
#define INCLUDE_xTaskAbortDelay (0)
#endif
#ifndef INCLUDE_xTaskGetHandle
#define INCLUDE_xTaskGetHandle (0)
#endif
#ifndef INCLUDE_xTaskResumeFromISR
#define INCLUDE_xTaskResumeFromISR (1)
#endif
#ifndef RM_FREERTOS_PORT_CFG_HW_STACK_MONITOR_ENABLE
#define RM_FREERTOS_PORT_CFG_HW_STACK_MONITOR_ENABLE  (0)
#endif
#ifndef configPRINT_STRING
#define configPRINT_STRING(x)                      (printf(x))
#endif
#ifndef configLOGGING_INCLUDE_TIME_AND_TASK_NAME
#define configLOGGING_INCLUDE_TIME_AND_TASK_NAME   (0)
#endif
#ifndef configLOGGING_MAX_MESSAGE_LENGTH
#define configLOGGING_MAX_MESSAGE_LENGTH           (192)
#endif
*/

//#endif /* FREERTOSCONFIG_H_ */
