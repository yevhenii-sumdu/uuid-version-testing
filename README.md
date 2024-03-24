# Does the UUID version affect the insertion time in PostgreSQL

PostgreSQL version 16.1 was used for testing.

The following UUID functions provided by the uuid-ossp module were tested:
- uuid_generate_v1()
- uuid_generate_v1mc()
- uuid_generate_v3()
- uuid_generate_v4()
- uuid_generate_v5()

The uuid-ossp module was installed using the following command included in the script:

```create extension if not exists "uuid-ossp";```

Test results:

![Screenshot_4](https://github.com/yevhenii-sumdu/uuid-version-testing/assets/113448886/9551793b-92f6-4d70-b628-5578631356e4)
