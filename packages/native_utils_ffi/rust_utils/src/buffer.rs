use aes_gcm::{aead::Buffer, Error};

#[derive(Debug)]
pub struct SliceBuffer<'a> {
    buffer: &'a mut [u8],
    len: usize,
}

impl <'a> SliceBuffer<'a> {
    pub fn buffer_with_empty_space(buffer: &'a mut [u8], empty_space_size: usize) -> Result<Self, Error> {
        if buffer.is_empty() {
            return Err(Error);
        }

        let data_area_len = match buffer.len().checked_sub(empty_space_size) {
            Some(len) => len,
            None => return Err(Error),
        };

        Ok(Self {
            buffer,
            len: data_area_len,
        })
    }
}

impl Buffer for SliceBuffer<'_> {
    fn extend_from_slice(&mut self, data: &[u8]) -> Result<(), Error> {
        if data.is_empty() {
            return Ok(());
        }

        let requested_len = self.len + data.len();
        if requested_len > self.buffer.len() {
            return Err(Error);
        }

        let (_, empty_space) = self.buffer.split_at_mut(self.len);
        let (target_area, _) = empty_space.split_at_mut(data.len());

        target_area.copy_from_slice(data);
        self.len += data.len();

        Ok(())
    }

    fn truncate(&mut self, len: usize) {
        // Only truncate
        if len >= self.len {
            return;
        }

        self.len = len;
    }
}

impl AsMut<[u8]> for SliceBuffer<'_> {
    fn as_mut(&mut self) -> &mut [u8] {
        &mut self.buffer[..self.len]
    }
}

impl AsRef<[u8]> for SliceBuffer<'_> {
    fn as_ref(&self) -> &[u8] {
        &self.buffer[..self.len]
    }
}


#[cfg(test)]
mod test {
    use aes_gcm::aead::Buffer;

    use crate::buffer::SliceBuffer;

    #[test]
    fn create_buffer_with_empty_space_successful() {
        let mut buffer = [0, 1];
        let slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 1).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[0]);
    }

    #[test]
    fn create_buffer_with_zero_empty_space_successful() {
        let mut buffer = [0, 1];
        let slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 0).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[0, 1]);
    }

    #[test]
    fn buffer_with_no_data_create_successful() {
        let mut buffer = [0, 1];
        let slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 2).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[] as &[u8]);
    }

    #[test]
    #[should_panic]
    fn zero_lenght_buffers_are_not_accepted() {
        SliceBuffer::buffer_with_empty_space(&mut [], 0).unwrap();
    }

    #[test]
    #[should_panic]
    fn too_much_empty_space_makes_error() {
        let mut buffer = [0, 1];
        SliceBuffer::buffer_with_empty_space(&mut buffer, 3).unwrap();
    }

    #[test]
    fn truncate_multiple_times_successful() {
        let mut buffer = [0, 1];
        let mut slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 0).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[0, 1]);
        slice_buffer.truncate(1);
        assert_eq!(slice_buffer.as_ref(), &[0]);
        slice_buffer.truncate(0);
        assert_eq!(slice_buffer.as_ref(), &[] as &[u8]);
        slice_buffer.truncate(0);
        assert_eq!(slice_buffer.as_ref(), &[] as &[u8]);
    }

    #[test]
    fn truncate_len_parameter_is_too_big_nothing_happens() {
        let mut buffer = [0, 1];
        let mut slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 0).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[0, 1]);
        slice_buffer.truncate(3);
        assert_eq!(slice_buffer.as_ref(), &[0, 1]);
    }

    #[test]
    #[should_panic]
    fn extend_from_slice_errors_if_no_space() {
        let mut buffer = [0, 1];
        let mut slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 0).unwrap();
        slice_buffer.extend_from_slice(&[2]).unwrap();
    }

    #[test]
    fn extend_from_slice_empty_slice_successful() {
        let mut buffer = [0, 1];
        let mut slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 0).unwrap();
        slice_buffer.extend_from_slice(&[]).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[0, 1]);
    }

    #[test]
    fn extend_from_slice_successful() {
        let mut buffer = [0, 1, 0];
        let mut slice_buffer = SliceBuffer::buffer_with_empty_space(&mut buffer, 1).unwrap();
        slice_buffer.extend_from_slice(&[2]).unwrap();
        assert_eq!(slice_buffer.as_ref(), &[0, 1, 2]);
    }
}
