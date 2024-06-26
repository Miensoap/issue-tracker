drop table if exists ISSUE_LABEL, ISSUE_MILESTONE, LABEL, MILESTONE, COMMENT, ISSUE, USERS;

create table USERS
(
    id          varchar(255) primary key,
    password    varchar(255),
    name        varchar(255)                       not null,
    created_at  timestamp                          not null,
    profile_img varchar(255),
    type        enum ('NORMAL', 'GITHUB', 'APPLE') not null default 'NORMAL'
);

create table MILESTONE
(
    id          bigint auto_increment primary key,
    name        varchar(255) not null,
    description text         not null,
    created_at  timestamp    not null,
    deadline    timestamp
);

create table ISSUE
(
    id               bigint auto_increment primary key,
    user_id          varchar(255)           not null,
    milestone_id     bigint,
    title            varchar(255)           not null,
    comment          text                   not null,
    created_at       timestamp              not null,
    last_modified_at timestamp              not null default current_timestamp,
    status           enum ('OPEN', 'CLOSE') not null default 'OPEN',
    foreign key (user_id) references USERS (id),
    foreign key (milestone_id) references MILESTONE (id)
);

create table LABEL
(
    id          bigint auto_increment primary key,
    name        varchar(255) not null,
    description text         not null,
    created_at  timestamp    not null,
    color       varchar(7)   not null default '#ffffff'
);

create table COMMENT
(
    id               bigint auto_increment primary key,
    user_id          varchar(255) not null,
    issue_id         bigint       not null,
    created_at       timestamp    not null,
    last_modified_at timestamp    not null default current_timestamp,
    hasEmoji         boolean      not null default false,
    foreign key (user_id) references USERS (id),
    foreign key (issue_id) references ISSUE (id)
);

create table ISSUE_LABEL
(
    id       bigint auto_increment primary key,
    issue_id bigint,
    label_id bigint,
    foreign key (issue_id) references ISSUE (id),
    foreign key (label_id) references LABEL (id)
);