mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}

        fn seat_at_table() {}
    }

    mod serving {
        fn take_order() {}

        fn serve_order() {}

        fn take_payment() {}
    }
}


fn deliver_order() {}

mod back_of_house {
    fn fix_incorrect_order() {
        cook_order();
        super::deliver_order();
    }

    fn cook_order() {}
}

pub fn eat_at_restaurant() {
    // Absolute path
    restaurant::front_of_house::hosting::add_to_waitlist();

    // Relative path
    front_of_house::hosting::add_to_waitlist();

}

// -------------

mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

use restaurant::front_of_house::hosting;
use restaurant::front_of_house::hosting::add_to_waitlist; // tambien se puede hacer esto


pub fn eat_at_restaurant() {
    hosting::add_to_waitlist(); // ✅ Shorter path
}
